# External Dependencies
require 'nokogiri'

# Internal Dependencies
['virtualbox/ext/platform',
  'virtualbox/ffi',
  'virtualbox/exceptions',
  'virtualbox/lib',
  'virtualbox/command',
  'virtualbox/abstract_model',
  'virtualbox/proxies/collection',
  'virtualbox/medium',
  'virtualbox/image',
  'virtualbox/attached_device',
  'virtualbox/dvd',
  'virtualbox/extra_data',
  'virtualbox/forwarded_port',
  'virtualbox/hard_drive',
  'virtualbox/nic',
  'virtualbox/usb',
  'virtualbox/shared_folder',
  'virtualbox/storage_controller',
  'virtualbox/vm',
  'virtualbox/media',
  'virtualbox/global',
  'virtualbox/system_property'].each do |lib|
  require File.expand_path(lib, File.dirname(__FILE__))
end

module VirtualBox
  class <<self
    # Returns installed VirtualBox version like '3.1.2r56127'.
    def version
      Command.vboxmanage("-v").chomp.strip
    end
  end
end