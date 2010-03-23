require 'ffi'

module VirtualBox
  module FFI
    extend ::FFI::Library

    XPCOMC_VERSION = 0x00020000
    NSRESULT_TYPE = :uint
    PRInt32 = :int
    PRUint16 = :ushort
    PRUint32 = :uint
    PRUnichar = PRUint16
    PRBool = :bool

    def self.init(lib_path)
      # Attach the library and the only function
      ffi_lib lib_path
      attach_function :VBoxGetXPCOMCFunctions, [ :uint ], :pointer

      # Initial the XPCOM C interface, and return the various instances
      # associated with it
      pVBOXXPCOMC = VBoxGetXPCOMCFunctions(XPCOMC_VERSION)
      xpcom = VBOXXPCOMC.new(pVBOXXPCOMC)
      vbox, session = xpcom.pfnComInitialize
      [xpcom, vbox, session]
    end
  end
end

# Load in the remaining structs and other files
%w{nsisupports vtbl vtbl_parent isession ivirtualbox vboxxpcomc imachine}.each do |file|
  require File.expand_path(File.join(File.dirname(__FILE__), 'ffi', file))
end