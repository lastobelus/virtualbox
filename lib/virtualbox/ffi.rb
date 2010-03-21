require 'ffi'

module VirtualBox
  module FFI
    extend ::FFI::Library

    NSRESULT_TYPE = :uint
    PRUint16 = :ushort
    PRUint32 = :uint
    PRUnichar = PRUint16
    PRBool = :boolean

    ffi_lib "/Applications/VirtualBox.app/Contents/MacOS/VBoxXPCOMC.dylib"
    attach_function :VBoxGetXPCOMCFunctions, [ :uint ], :pointer
  end
end

# Load in the remaining structs and other files
%w{nsisupports isession ivirtualbox vboxxpcomc}.each do |file|
  require File.expand_path(File.join(File.dirname(__FILE__), 'ffi', file))
end