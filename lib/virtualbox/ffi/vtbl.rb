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

      @@_scoped_opts = {}

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

        # This method allows a group of members to be scoped with a given set
        # of options. Example:
        #
        #   with_opts(:function_type_prefix => :foo_) do
        #     member :Foo, :getter, :int
        #     member :Bar, :getter, :string
        #   end
        #
        def with_opts(opts, &block)
          # Merge in the previous value, so nested scopes work
          previous_value = @@_scoped_opts
          @@_scoped_opts = previous_value.merge(opts)

          # Instance eval instead of yield to run in context of class
          instance_eval(&block)

          # Pop back the previous value onto the scoped opts
          @@_scoped_opts = previous_value
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
        #   nsresult (*GetFoo)(IInterface *this, ResultType *result);
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
        def member_getter(key, type, opts={})
          # Merge in default options
          default_opts = {
            :function_type => key,
            :function_type_prefix => nil
          }
          opts = default_opts.merge(scoped_opts).merge(opts)

          # Add the function to the layout args per normal
          function_type = opts[:function_type_prefix] ? "#{opts[:function_type_prefix]}#{opts[:function_type]}".to_sym : opts[:function_type]
          layout_args << [key, function_type]

          # Define the getter
          define_method(Util.functionify(key)) do
            Util.pointer_for_type(type) do |pointer, inferred_type|
              self[key].call(parent, pointer)
              Util.dereference_pointer(pointer, type)
            end
          end
        end

        # This method adds an array getter function to the struct. The getter
        # functions which return arrays typically have a prototype of:
        #
        #   nsresult (*GetFoos)(IInterface *this, PRUint32 *size, ResultType **result);
        #
        # By defining it as an array getter function, the VTbl struct automatically
        # creates the instance method `get_foos` for it, automatically returning
        # an array of the proper type, allowing the caller to avoid handling all the
        # pointer logic.
        #
        # This method requires two parameters. The first is simply the name of the
        # get method in C. This method will automatically be turned into a more
        # Ruby-style name. Ex: `GetDiskDrives` => `get_disk_drives`
        #
        # The second parameter is the type of a single element of the array returned.
        # This type can be one of the typical Ruby-FFI primitives or it can also
        # be a symbol or class representing another struct.
        def member_array_getter(key, type, opts={})
          # Merge in default options
          default_opts = {
            :function_type => key,
            :function_type_prefix => nil
          }
          opts = default_opts.merge(scoped_opts).merge(opts)

          # Add the function to the layout args per normal
          function_type = opts[:function_type_prefix] ? "#{opts[:function_type_prefix]}#{opts[:function_type]}".to_sym : opts[:function_type]
          layout_args << [key, function_type]

          # Define the array getter
          define_method(Util.functionify(key)) do
            count_pointer = Util.pointer_for_type(PRUint32)
            array_pointer = Util.pointer_for_type(type)

            self[key].call(parent, count_pointer, array_pointer)

            count = Util.dereference_pointer(count_pointer, PRUint32)
            Util.dereference_pointer_array(array_pointer, type, count)
          end
        end

        # This method adds a general `function` type to the layout. This method is more
        # specific than Ruby-FFI's `callback` in that it automatically handles creating
        # pointers for out parameters and wrapping in parameters in pointers as well if
        # that is what is needed.
        #
        # Its also tailored specifically to VirtualBox in that the return value, typically
        # `nsresult` is never actually returned. Instead, the parameters specified as
        # `out` parameters are returned as an array (or just a single object if there is just
        # one).
        #
        # The params array is simply an array of types as symbols. Example of a simple one:
        #
        #   [:int, :string, :uint, :SomeStruct]
        #
        # Things can get more complicated with `parameter flags`. An example of parameter
        # flags in use is shown below:
        #
        #   [:int, [:out, :string], :uint]
        #
        # In this case, the 2nd parameter is an output parameter, meaning its just a pointer
        # that the function uses to return a value rather than return it through the function.
        # For functions like this, `member_function` will ignore that 2nd parameter when
        # creating the function, and use it as a return value. Example, if the above function
        # was called `foo`:
        #
        #   foo(-7, 42) # => Returns a string
        #
        def member_function(key, params, opts={})
          # Merge in default options
          default_opts = {
            :function_type => key,
            :function_type_prefix => nil
          }
          opts = default_opts.merge(scoped_opts).merge(opts)

          # Add the function to the layout args per normal
          function_type = opts[:function_type_prefix] ? "#{opts[:function_type_prefix]}#{opts[:function_type]}".to_sym : opts[:function_type]
          layout_args << [key, function_type]

          # Create the method
          define_method(Util.functionify(key)) do |*args|
            # TODO: Verify parameters count and types

            # Generate the parameters array we're sending to the function
            filtered_params = params.collect do |param|
              if param.is_a?(Array) && param[0] == :out
                # Output parameter, create the pointer for it and put it onto
                # the array, ignoring the args
                Util.pointer_for_type(param[1])
              elsif param == :unicode_string
                # We have to convert the string to a UTF16 string
                Util.string_to_utf16(args.shift)
              else
                # Replace param with the next parameter in the args list,
                # removing it as well
                args.shift
              end
            end

            # Call the function
            self[key].call(parent, *filtered_params)

            # Grab return values
            return_values = []
            params.each_with_index do |param, i|
              # Output parameters are all we care about
              if param.is_a?(Array) && param[0] == :out
                return_values << Util.dereference_pointer(filtered_params[i], param[1])
              end
            end

            # Return the return values
            return_values
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

        # The scoped options. These are set using {with_opts}. These should not be
        # modified directly
        def scoped_opts
          @@_scoped_opts ||= {}
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
    end
  end
end