# External Dependencies
require 'nokogiri'

# The virtualbox files which must be loaded prior to the rest
libdir = File.dirname(__FILE__)
%w{virtualbox/ext/platform virtualbox/ext/subclass_listing virtualbox/ffi
  virtualbox/abstract_model virtualbox/medium}.each do |f|
  require File.expand_path(f, libdir)
end

# Glob require the rest
Dir[File.join(libdir, "virtualbox", "**", "*.rb")].each do |f|
  require File.expand_path(f)
end

# Setup the top-level module methods
module VirtualBox
  extend Version
end