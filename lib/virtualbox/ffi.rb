require 'ffi'

module VirtualBox
  module FFI
    extend ::FFI::Library

    XPCOMC_VERSION = 0x00020000
    NSRESULT_TYPE = :uint
    PRInt32 = :int
    PRInt64 = :long
    PRUint16 = :ushort
    PRUint32 = :uint
    PRUint64 = :ulong
    PRUnichar = PRUint16
    PRBool = :char

    # Convenience method to initialize the VirtualBox XPCOM C interface.
    # This method handles setting up the function pointers, creating the
    # {VBOXXPCOMC} object, and also grabbing the {IVirtualBox} and
    # {ISession} objects.
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

# The FFI directory of the gem
ffidir = File.join(File.dirname(__FILE__), 'ffi')

# Load in the initially required files, which must be loaded prior
# to the rest
%w{util vtbl vtbl_parent enum nsisupports nsiexception nsistack_frame iusb_device iusb_device_filter}.each do |f|
  require File.expand_path(f, ffidir)
end

# Glob require the rest
Dir[File.join(ffidir, "**", "*.rb")].each do |f|
  require File.expand_path(f)
end