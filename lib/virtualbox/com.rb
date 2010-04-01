module VirtualBox
  module COM
    WSTRING = :unicode_string
  end
end

# The com directory of the gem
comdir = File.join(File.dirname(__FILE__), 'com')

# Load in the initially required files, which must be loaded prior
# to the rest
%w{abstract_interface abstract_implementer ffi/interface}.each do |f|
  require File.expand_path(f, comdir)
end

# Glob require the rest
Dir[File.join(comdir, "**", "*.rb")].each do |f|
  require File.expand_path(f)
end