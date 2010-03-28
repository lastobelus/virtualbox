module VirtualBox
  class AbstractModel
    # Module which can be included which defines helper methods to DRY out the
    # code which handles attributes with {VirtualBox::FFI} interfaces. This
    # module works _alongside_ the {Attributable} module, so **both are required**.
    module InterfaceAttributes
      # Loads the attributes which have an interface getter and writes
      # their values.
      #
      # @param [VirtualBox::FFI::VTbl] interface
      def load_interface_attributes(interface)
        self.class.attributes.each do |key, options|
          load_interface_attribute(key, interface)
        end
      end

      # Loads a single interface attribute.
      #
      # @param [Symbol] key The attribute to load
      # @param [VirtualBox::FFI::VTbl] interface The interface
      def load_interface_attribute(key, interface)
        # Return unless we have a valid interface attribute with a getter
        return unless has_attribute?(key)
        getter = self.class.attributes[key.to_sym][:interface_getter]
        return unless getter

        # Convert the getter to a proc and call it
        getter = spec_to_proc(getter)
        write_attribute(key, getter.call(interface))
      end

      # Converts a getter/setter specification to a Proc which can be called
      # to obtain or set a value. There are multiple ways to specify the getter
      # and/or setter of an interface attribute:
      #
      # ## Symbol
      #
      # A symbol represents a method to call on the interface. An example of the
      # declaration and resulting method call are shown below:
      #
      #     attribute :foo, :interface_getter => :get_foo
      #
      # Converts to:
      #
      #     interface.get_foo
      #
      # ## Proc
      #
      # A proc is called with the interface and it is expected to return the value
      # for a getter. For a setter, the interface and the value is sent in as
      # parameters to the Proc.
      #
      #     attribute :foo, :interface_getter => Proc.new { |i| i.get_foo }
      #
      def spec_to_proc(spec)
        # Return the spec as-is if its a proc
        return spec if spec.is_a?(Proc)

        if spec.is_a?(Symbol)
          # For symbols, wrap up a method send in a Proc and return
          # that
          return Proc.new { |m| m.send(spec) }
        end
      end
    end
  end
end