module VirtualBox
  module COM
    module Implementer
      class MSCOM < AbstractImplementer
        attr_reader :lib
        attr_reader :object

        # Initializes the MSCOM implementer.
        #
        # @param [AbstractInterface] inteface
        # @param [FFI::Pointer] pointer
        def initialize(interface, lib_base, object)
          super(interface)

          @lib = lib_base
          @object = object
        end

        # Reads a property from the interface with the given name.
        def read_property(name, opts)
          # First get the basic value from the COM object
          value = @object[COM::FFI::Util.camelize(name.to_s)]

          # Then depending on the value type, we either return as-is or
          # must wrap it up in another interface class
          returnable_value(value, opts[:value_type])
        end

        def returnable_value(value, type)
          # Try to get an interface from the type and if so, wrap it up
          interface_klass = COM::Interface.const_get(type)
          interface_klass.new(self.class, lib, value)
        rescue NameError
          value
        end
      end
    end
  end
end