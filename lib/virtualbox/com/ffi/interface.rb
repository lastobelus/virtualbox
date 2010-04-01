require 'ffi'

module VirtualBox
  module COM
    module FFI
      extend ::FFI::Library

      # Returns a Class which creates an FFI interface to the specified
      # com interface and potentially a parent class as well.
      def self.Interface(parent=nil)
        klass = Class.new(Interface)
        # TODO: Define the parent/com interface
      end

      # Represents a VirtualBox XPCOM C interface, which is a C struct
      # which emulates an object (a struct with function pointers
      # and getters/setters).
      class Interface
        class <<self
          # Sets up the args to the FFI::Struct `layout` method. This
          # method defines all the callbacks necessary for working with
          # FFI and also sets up any layout args to send in.
          def com_interface(interface)

          end
        end
      end
    end
  end
end