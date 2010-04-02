module VirtualBox
  module COM
    WSTRING = :unicode_string
    T_INT64 = :long
    T_ULONG = :ulong
    T_UINT32 = :uint
    T_BOOL = :char
  end
end

# The com directory of the gem
comdir = File.join(File.dirname(__FILE__), 'com')

# Require the abstract interface first then glob load all
# of the interfaces
require File.expand_path("abstract_interface", comdir)
VirtualBox::GlobLoader.glob_require(File.join(comdir, "interface"))
VirtualBox::GlobLoader.glob_require(comdir, %w{abstract_interface abstract_implementer util ffi/interface ffi/util})
