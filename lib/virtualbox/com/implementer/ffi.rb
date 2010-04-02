module VirtualBox
  module COM
    module Implementer
      class FFI < AbstractImplementer
        attr_reader :ffi_interface
        attr_reader :lib

        # Initializes the FFI implementer which takes an {AbstractInteface}
        # instant and FFI pointer and initializes everything required to
        # communicate with that interface via FFI.
        #
        # @param [AbstractInterface] inteface
        # @param [FFI::Pointer] pointer
        def initialize(interface, lib_base, pointer)
          super(interface)

          @lib = lib_base
          @ffi_interface = ffi_class.new(pointer)
        end

        # Gets the FFI struct class associated with the interface. This works
        # by stripping the namespace off of the interface class and finding that
        # same class within the `COM::FFI` namespace. For example:
        # `VirtualBox::COM::Interface::Session` becomes `VirtualBox::COM::FFI::Session`
        #
        # @return [Class]
        def ffi_class
          # Take off the last part of the class, so `Foo::Bar::Baz` becomes
          # just `Baz`
          klass_name = interface.class.to_s.split("::").last

          # Get the associated FFI class
          COM::FFI.const_get(klass_name)
        end

        # Reads a property from the interface with the given name.
        def read_property(name, opts)
          call_vtbl_function("get_#{name}".to_sym, [[:out, opts[:value_type]]])
        end

        # Calls a function on the vtbl of the FFI struct. This function handles
        # converting the spec to proper arguments and also handles reading out
        # the arguments, dereferencing pointers, setting up objects, etc. so that
        # the return value is filled with nicely formatted Ruby objects.
        #
        # If the vtbl function being called only has one out parameter, then the
        # return value will be that single object. If it has multiple, then it will
        # be an array of objects.
        def call_vtbl_function(name, spec, args=[])
          # Get the "formal argument" list. This is the list of arguments to send
          # to the actual function based on the spec. This contains pointers, some
          # arguments from `args`, etc.
          formal_args = spec_to_args(spec, args)

          # Call the function. Error checking TODO.
          ffi_interface.vtbl[name].call(ffi_interface.vtbl_parent, *formal_args)

          # Extract the values from the formal args array, again based on the
          # spec (and the various :out parameters)
          values_from_formal_args(spec, formal_args)
        end

        #############################################################
        # Internal Methods, a.k.a. unless you're hacking on the code of this
        # library, you should do well to leave these alone =]
        #############################################################

        # Converts a function spec to a proper argument list with the given
        # arguments.
        #
        # @return [Array]
        def spec_to_args(spec, args=[])
          spec = spec.collect do |item|
            if item.is_a?(Array) && item[0] == :out
              if item[1].is_a?(Array)
                # TODO
              else
                pointer_for_type(item[1])
              end
            elsif item == WSTRING
              # TODO: Convert args to unicode string
            elsif item.to_s[0,1] == item.to_s[0,1].upcase
              # TODO: Get interface instance, create pointer to it
            else
              # Simply replace spec item with next item in args
              # list
              args.shift
            end
          end
        end

        # Takes a spec and a formal parameter list and returns the output from
        # a function, properly dereferencing any output pointers.
        #
        # @param [Array] specs The parameter spec for the function
        # @param [Array] formal The formal parameter list
        def values_from_formal_args(specs, formal)
          return_values = []
          specs.each_with_index do |spec, i|
            # Output parameters are all we care about
            if spec.is_a?(Array) && spec[0] == :out
              return_values << dereference_pointer(formal[i], spec[1])
            end
          end

          if return_values.empty?
            nil
          elsif return_values.length == 1
            return_values.first
          else
            return_values
          end
        end

        # Dereferences a pointer with a given type into a proper Ruby object.
        # If the type is a standard primitive of Ruby-FFI, it simply calls the
        # proper `get_*` method on the pointer. Otherwise, it calls a
        # `read_*` on the Util class. For an example, see {read_struct}, which
        # reads a struct out of a pointer.
        #
        # @param [FFI::MemoryPointer] pointer
        # @param [Symbol] type The type of the pointer
        # @return [Object] The value of the dereferenced pointer
        def dereference_pointer(pointer, type)
          c_type, inferred_type = infer_type(type)

          if pointer.respond_to?("get_#{inferred_type}".to_sym)
            # This handles reading the typical times such as :uint, :int, etc.
            result = pointer.send("get_#{inferred_type}".to_sym, 0)
            result = !(result == 0) if type == COM::T_BOOL
            result
          else
            send("read_#{inferred_type}".to_sym, pointer, type)
          end
        end

        # Gives the C type and inferred type of a parameter type. Quite confusing
        # since the terminology is not consistent, but hopefully these examples
        # will help:
        #
        #   type => [pointer_type, internal_type]
        #   :int => [:int, :int]
        #   :MyStruct => [:pointer, :struct]
        #   :unicode_string => [:pointer, :unicode_string]
        #
        def infer_type(type)
          c_type = type

          begin
            if type == WSTRING
              # Handle strings as pointer types
              c_type = :pointer
            else
              # Try to get the class from the interfaces
              interface = COM::Interface.const_get(type)

              c_type = :pointer
              type = :interface
            end
          rescue NameError
            # Do nothing
          end

          [c_type, type]
        end

        # Converts a symbol type into a MemoryPointer and yield a block
        # with the pointer, the C type, and the FFI type
        def pointer_for_type(type)
          c_type, type = infer_type(type)

          # Create the pointer, yield, returning the result of the block
          # if a block is given, or otherwise just returning the pointer
          # and inferred type
          pointer = ::FFI::MemoryPointer.new(c_type)
          if block_given?
            yield pointer, type
          else
            pointer
          end
        end

        # Converts a UTF16 string to UTF8
        def utf16_to_string(pointer)
          result_pointer = pointer_for_type(:pointer)
          lib.xpcom[:pfnUtf16ToUtf8].call(pointer, result_pointer)
          lib.xpcom[:pfnUtf16Free].call(pointer)
          result_pointer.read_pointer().read_string().to_s
        end

        # Reads a unicode string value from a pointer to that value.
        #
        # @return [String]
        def read_unicode_string(ptr, original_type=nil)
          address = ptr.get_pointer(0)
          return "" if address.null?
          utf16_to_string(address)
        end

        # Reads an interface from the pointer
        #
        # @return [::FFI::Struct]
        def read_interface(ptr, original_type)
          ptr = ptr.get_pointer(0)
          return nil if ptr.null?

          klass = COM::Interface.const_get(original_type)
          klass.new(self.class, lib, ptr)
        end
      end
    end
  end
end