module VirtualBox
  module COM
    module FFI
      # Class which contains many class-level utility methods to assist
      # with the FFI interface. These functions range from converting a
      # function spec to a FFI parameter list to dereferencing pointers.
      class Util
        class <<self
          def spec_to_ffi(spec)
            spec = spec.collect do |item|
              if item.is_a?(Array) && item[0] == :out
                # All "out" parameters are pointers
                :pointer
              elsif item == :unicode_string
                # Unicode strings are simply pointers
                :pointer
              elsif item.to_s[0,1] == item.to_s[0,1].upcase
                # Names that start with a capital letter are assumed to be
                # classes; make them a pointer
                :pointer
              else
                # Unknown items are simply passed as-is, hopefully FFI
                # will catch any problems
                item
              end
            end

            # Prepend a :pointer to represent the `this` parameter required
            # for the FFI parameter lists
            spec.unshift(:pointer)
          end

          def camelize(string)
            special_cases = {
              "os" => "OS",
              "dhcp" => "DHCP"
            }

            parts = string.to_s.split(/_/).collect do |part|
              special_cases[part] || part.capitalize
            end

            parts.join("")
            #string.to_s.gsub(/\/(.?)/) { "::" + $1.upcase }.gsub(/(^|_)(.)/) { $2.upcase }
          end
        end
      end
    end
  end
end