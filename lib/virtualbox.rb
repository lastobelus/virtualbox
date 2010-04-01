# Load the glob loader, which will handle the loading of all the other files
libdir = File.join(File.dirname(__FILE__), "virtualbox")
require File.expand_path("ext/glob_loader", libdir)

# Load them up
VirtualBox::GlobLoader.glob_require(libdir, %w{ext/platform ext/subclass_listing ffi com abstract_model medium})

# Setup the top-level module methods
module VirtualBox
  extend Version
end