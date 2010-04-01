module VirtualBox
  module COM
    module Implementer
      class FFI < AbstractImplementer
        attr_reader :ffi_interface

        # Initializes the FFI implementer which takes an {AbstractInteface}
        # instant and FFI pointer and initializes everything required to
        # communicate with that interface via FFI.
        #
        # @param [AbstractInterface] inteface
        # @param [FFI::Pointer] pointer
        def initialize(interface, pointer)
          super(interface)

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
      end
    end
  end
end