module VirtualBox
  module FFI
    # Represents a *_vtbl class for the various vtbl classes which exist
    # within the VirtualBox C API. This class aims to eliminate the
    # redundancy between the many implementations of the vtbl classes and
    # also attempts to make the functions more "ruby-like" by allowing
    # Ruby programmers to avoid the pointers, and having return values
    # returned directly.
    class VTbl < ::FFI::Struct
      attr_reader :parent

      class <<self
        # This method replaces the `layout` method of `FFI::Struct`. Instead
        # of defining all members using many parameters to `layout`, pass a
        # block to {define_layout} and call {member} within it to define
        # the various members.
        def define_layout(&block)
          # First, clear out the layout args so we don't get any overlap
          layout_args.clear

          # Instance eval in block to make all the {member} calls
          instance_eval(&block)

          # Commit all of them using the old-style `layout` method
          layout(*layout_args.flatten)
        end

        # This method helps to replace the `layout` method of `FFI::Struct`. Instead
        # of defining all members of a struct in a single class declaration,
        # each member must be defined with the {member} function within a
        # {define_layout} method. The order they are defined results in the order
        # they are passed to `layout`.
        #
        # While `layout` works perfectly well in most cases, the way that the
        # VirtualBox API is structured makes it extremely redundant, and this
        # new {member} function allows for implementing instance methods for
        # the function pointers and so on.
        #
        # @param [Symbol] key The variable name of the member
        # @param [Symbol] type The type of the member.
        def member(key, type, *args)
          if respond_to?("member_#{type}".to_sym)
            # Special member type, call the specific function to set it up
            send("member_#{type}".to_sym, key, *args)
          else
            # Typical type (:int, :string, etc.), just push it on
            layout_args << [key, type]
          end
        end

        # This method adds a getter function to the struct. The getter functions
        # typically have a prototype of:
        #
        #   nsresult (*SomeFunction)(IInterface *this, ResultType *result);
        #
        # By defining it as a getter function, the VTbl struct automatically
        # creates the instance method `get_foo` for it, automatically returning
        # the proper type, allowing the caller to avoid handling the pointer
        # hoops.
        #
        # This method requires two parameters. The first is simply the name of
        # the get method in C. The second, the `type`, is the type of the value
        # returned from the function (via the 2nd pointer parameter). For example,
        # with the above example, the type should be `:ResultType`, and not a
        # pointer, since the actual resulting type is `ResultType`, and the pointer
        # is just a means to return it.
        def member_getter(key, type)
          # Add the function to the layout args per normal
          layout_args << [key, key]

          # Define the getter
          define_method(Util.functionify(key)) do
            Util.pointer_for_type(type) do |pointer, inferred_type|
              self[key].call(parent, pointer)

              # Now, depending on the type, we return different values
              if pointer.respond_to?("get_#{inferred_type}".to_sym)
                # This handles reading the typical times such as :uint, :int, etc.
                pointer.send("get_#{inferred_type}".to_sym, 0)
              else
                send("read_#{inferred_type}".to_sym, pointer, type)
              end
            end
          end
        end

        # Returns an array of the layout args to send to `layout` eventually.
        # This method is used internally by {member} for bookkeeping the various
        # members and is committed by calling {commit}. This method will typically
        # never be accessed except internally.
        #
        # @return [Array]
        def layout_args
          @_layout_args ||= []
        end
      end

      # Initializes a new VTbl object, setting the parent to the `parent`
      # argument. {VTbl} structs for VirtualBox differ in that they all require
      # a parent which functions as the `this` argument for the various functions
      # which are called on the methods.
      #
      # @param [Object] parent
      def initialize(parent, *args)
        super(*args)

        @parent = parent
      end

      # Returns a reference to the main XPCOMC object, which is gathered
      # via {VirtualBox::Lib.xpcom}.
      #
      # @return [VBOXXPCOMC]
      def xpcom
        VirtualBox::Lib.xpcom
      end

      # Reads a unicode string value from a pointer to that value.
      #
      # @return [String]
      def read_unicode_string(ptr, original_type)
        xpcom[:pfnUtf16ToUtf8].call(ptr.get_pointer(0), ptr)
        ptr.read_pointer().read_string().to_s
      end
    end
  end
end