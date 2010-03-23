module VirtualBox
  module FFI
    # Utility class for the FFI. This class contains methods which
    # are used around FFI to provide utility to the library.
    class Util
      class <<self
        # Converts a symbol type into a MemoryPointer and yield a block
        # with the pointer, the C type, and the FFI type
        def pointer_for_type(type)
          c_type = type

          begin
            if type == :unicode_string
              # Handle strings as pointer types
              c_type = :pointer
            elsif type.is_a?(Class) || FFI.const_get(type)
              # The type is another struct (FFI::Struct), so we read it
              # as a pointer but handle it as a generic struct
              c_type = :pointer
              type = :struct
            end
          rescue NameError
            # Do nothing
          end

          # Create the pointer, yield
          pointer = ::FFI::MemoryPointer.new(c_type)
          yield pointer, type
        end

        # Converts a C-style member name such as `GetVersion` into a Ruby-style
        # method name such as `get_version`
        def functionify(c_string)
          # Yes, this is a pretty inefficient/verbose way to do this, but it works
          c_string.to_s.gsub(/([a-z])([A-Z0-9])/, '\1 \2').strip.gsub(' ', '_').downcase.to_sym
        end
      end
    end
  end
end