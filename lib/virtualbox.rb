# External Dependencies
require 'nokogiri'

# Internal Dependencies
['virtualbox/ext/platform',
  'virtualbox/ext/subclass_listing',
  'virtualbox/ffi',
  'virtualbox/exceptions',
  'virtualbox/lib',
  'virtualbox/abstract_model',
  'virtualbox/proxies/collection',
  'virtualbox/medium',
  'virtualbox/medium_attachment',
  'virtualbox/dvd',
  'virtualbox/extra_data',
  'virtualbox/forwarded_port',
  'virtualbox/hard_drive',
  'virtualbox/network_adapter',
  'virtualbox/shared_folder',
  'virtualbox/storage_controller',
  'virtualbox/bios',
  'virtualbox/vm',
  'virtualbox/media',
  'virtualbox/global'].each do |lib|
  require File.expand_path(lib, File.dirname(__FILE__))
end

module VirtualBox
  class <<self
    # Returns installed VirtualBox version like '3.1.2r56127'.
    def version
      # TODO
    end
  end
end