module VirtualBox
  module FFI
    # Utility class for the FFI. This class contains methods which
    # are used around FFI to provide utility to the library.
    class Util
      class <<self
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
            pointer.send("get_#{inferred_type}".to_sym, 0)
          else
            send("read_#{inferred_type}".to_sym, pointer, type)
          end
        end

        # Dereferences an array out of a pointer into an array of proper Ruby
        # objects.
        #
        # @param [FFI::MemoryPointer] pointer
        # @param [Symbol] type The type of the pointer
        # @param [Fixnum] length The length of the array
        # @return [Array<Object>]
        def dereference_pointer_array(pointer, type, length)
          # If there are no items in the pointer, just return an empty array
          return [] if length == 0

          c_type, inferred_type = infer_type(type)

          array_pointer = pointer.get_pointer(0)
          if array_pointer.respond_to?("get_array_of_#{inferred_type}".to_sym)
            # This handles reading the typical times such as :uint, :int, etc.
            array_pointer.send("get_array_of_#{inferred_type}".to_sym, 0, length)
          else
            send("read_array_of_#{inferred_type}".to_sym, array_pointer, type, length)
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
            if type == :unicode_string
              # Handle strings as pointer types
              c_type = :pointer
            elsif type.is_a?(Array)
              # Handle arrays as pointer types
              c_type = :pointer
              type = :array
            elsif type.is_a?(Class) || FFI.const_get(type)
              # The type is another struct (FFI::Struct), so we read it
              # as a pointer but handle it as a generic struct
              c_type = :pointer
              type = :struct
            end
          rescue NameError
            # Do nothing
          end

          [c_type, type]
        end

        # Takes a parameter list spec for a function, and the arguments to pass
        # to it, and converts it to a formal argument list for the actual function.
        # An example conversion is shown below with some pseudo-code:
        #
        #   spec = [:int, :unicode_string, [:out, :FooStruct]]
        #   args = [7, "foo"]
        #   formal_list = [7, "foo".to_utf16, MemoryPointer]
        #
        def formal_params(specs, args)
          # Dup the args so they aren't clobbered by reference
          args = args.dup

          specs.collect do |spec|
            if spec.is_a?(Array) && spec.length == 2 && spec[0] == :out
              # Output parameter, create the pointer for it and put it onto
              # the array, ignoring the args
              Util.pointer_for_type(spec[1])
            elsif spec == :unicode_string
              # We have to convert the string to a UTF16 string
              Util.string_to_utf16(args.shift)
            else
              # Replace param with the next parameter in the args list,
              # removing it as well
              args.shift
            end
          end
        end

        # Takes a spec and a formal parameter list and returns the output from
        # a function, properly dereferencing any output pointers.
        #
        # @param [Array] specs The parameter spec for the function
        # @param [Array] formal The formal parameter list
        def values_from_formal_params(specs, formal)
          return_values = []
          specs.each_with_index do |spec, i|
            # Output parameters are all we care about
            if spec.is_a?(Array) && spec[0] == :out
              return_values << Util.dereference_pointer(formal[i], spec[1])
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

        # Converts a ruby string to a UTF16 string
        #
        # @param [String] Ruby String object
        # @return [::FFI::Pointer]
        def string_to_utf16(string)
          ptr = pointer_for_type(:pointer)
          VirtualBox::Lib.xpcom[:pfnUtf8ToUtf16].call(string, ptr)
          ptr.read_pointer()
        end

        # Converts a UTF16 string to UTF8
        def utf16_to_string(pointer)
          result_pointer = pointer_for_type(:pointer)
          VirtualBox::Lib.xpcom[:pfnUtf16ToUtf8].call(pointer, result_pointer)
          result_pointer.read_pointer().read_string().to_s
        end

        # Reads a unicode string value from a pointer to that value.
        #
        # @return [String]
        def read_unicode_string(ptr, original_type=nil)
          utf16_to_string(ptr.get_pointer(0))
        end

        # Reads a struct from the pointer
        #
        # @return [::FFI::Struct]
        def read_struct(ptr, original_type)
          klass = FFI.const_get(original_type)
          klass.new(ptr.get_pointer(0))
        end

        # Reads an array of structs from a pointer
        #
        # @return [Array<::FFI::Struct>]
        def read_array_of_struct(ptr, type, length)
          klass = FFI.const_get(type)
          ptr.get_array_of_pointer(0, length).collect do |single_pointer|
            klass.new(single_pointer)
          end
        end

        # Reads an array of strings from a pointer
        #
        # @return [Array<String>]
        def read_array_of_unicode_string(ptr, type, length)
          ptr.get_array_of_pointer(0, length).collect do |single_pointer|
            utf16_to_string(single_pointer)
          end
        end

        # Converts a C-style member name such as `GetVersion` into a Ruby-style
        # method name such as `get_version`
        def functionify(c_string)
          # Replace the word breaks such as "GetFoo" with "Get Foo"
          c_string = c_string.to_s.gsub(/([a-z])([A-Z0-9])/, '\1 \2')

          # Replace word breaks such as "DVDImages" with "DVD Images"
          c_string = c_string.gsub(/([A-Z0-9])([A-Z0-9])([a-z])/, '\1 \2\3')

          # Strip any trailing whitespace, replaces spaces with underscores, and
          # downcase the whole thing. Ex: "Get DVD Images " => "get_dvd_images"
          c_string.strip.gsub(' ', '_').downcase.to_sym
        end
      end
    end
  end
end