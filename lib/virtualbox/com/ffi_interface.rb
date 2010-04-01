module VirtualBox
  module COM
    class FFIInterface
      extend ::FFI::Library

      # Constant used to initialize the XPCOM C interface
      XPCOMC_VERSION = 0x00020000

      class <<self
        def create(lib_path=nil)
          # Setup the path to the C library
          lib_path ||= "/Applications/VirtualBox.app/Contents/MacOS/VBoxXPCOMC.dylib"

          # Attach to the interface
          ffi_lib lib_path
          attach_function :VBoxGetXPCOMCFunctions, [:uint], :pointer

          # Get the pointer to the XPCOMC struct and use that to initialize
          pVBOXXPCOMC = VBoxGetXPCOMCFunctions(XPCOMC_VERSION)
          xpcom = FFI::VBOXXPCOMC.new(pVBOXXPCOMC)
          vbox, session = xpcom.pfnComInitialize
          [xpcom, vbox, session]
        end
      end
    end
  end
end