module VirtualBox
  module COM
    class FFIInterface
      extend ::FFI::Library

      # Constant used to initialize the XPCOM C interface
      XPCOMC_VERSION = 0x00020000

      class <<self
        # THIS IS ALL GOING TO BE REDONE. TODO
        def create(lib_path=nil)
          # Setup the path to the C library
          lib_path ||= "/Applications/VirtualBox.app/Contents/MacOS/VBoxXPCOMC.dylib"

          # Attach to the interface
          ffi_lib lib_path
          attach_function :VBoxGetXPCOMCFunctions, [:uint], :pointer

          # Get the pointer to the XPCOMC struct and use that to initialize
          pVBOXXPCOMC = VBoxGetXPCOMCFunctions(XPCOMC_VERSION)
          xpcom = FFI::VBOXXPCOMC.new(pVBOXXPCOMC)
          vbox_ptr = ::FFI::MemoryPointer.new(:pointer)
          session_ptr = ::FFI::MemoryPointer.new(:pointer)

          # Initialize the xpcom library and the interfaces returned
          xpcom[:pfnComInitialize].call(COM::Interface::VirtualBox::IID_STR, vbox_ptr, COM::Interface::Session::IID_STR, session_ptr)
          vbox = Interface::VirtualBox.new(Implementer::FFI, vbox_ptr.get_pointer(0))
          session = Interface::Session.new(Implementer::FFI, session_ptr.get_pointer(0))
          [xpcom, vbox, session]
        end
      end
    end
  end
end