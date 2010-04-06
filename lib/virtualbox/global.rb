module VirtualBox
  # Represents the VirtualBox main configuration file (VirtualBox.xml)
  # which VirtualBox uses to keep track of all known virtual machines
  # and images. This "global" configuration has many relationships which
  # allow the user to retrieve a list of all VMs, media, global extra data,
  # etc. Indeed, even methods like {VM.all} are implemented using this class.
  #
  # # Setting the Path to VirtualBox.xml
  #
  # **This is extremely important.**
  #
  # Much of the virtualbox gem requires a proper path to the global XML configuration
  # file for VirtualBox. This path is system and installation dependent. {Global}
  # does its best to guess the path by trying the default paths based on the
  # platform ruby is running on, but this is hardly foolproof. If you receive an
  # {Exceptions::ConfigurationException} at some point while running virtualbox,
  # you should use {Global.vboxconfig=} to set the path. An example is below:
  #
  #     # Most installations won't need to do this, since the gem "guesses"
  #     # the path based on OS, but if you need to set vboxconfig path
  #     # explicitly:
  #     VirtualBox::Global.vboxconfig = "~/.MyCustom/VirtualBox.xml"
  #
  # # Getting Global Data
  #
  # To retrieve the global data, use `Global.global`. This value is _cached_
  # between calls, so subsequent calls will not go through the entire parsing
  # process. To force a reload, set the `reload` parameter to true. Besides
  # setting the parameter explicitly, some actions will implicitly force the
  # global data to reload on the next call, such as saving a VM or destroying
  # an image, for example.
  #
  #     # Retrieve global data for the first time. This will parse all the
  #     # data.
  #     global_object = VirtualBox::Global.global
  #
  #     # Subsequent calls are near-instant:
  #     VirtualBox::Global.global
  #
  #     # Or we can choose to reload the data...
  #     reloaded_object = VirtualBox::Global.global(true)
  #
  # # Relationships
  #
  # While a global object doesn't have attributes, it does have many
  # relationships. The relationships are listed below. If you don't
  # understand this, read {Relatable}.
  #
  #     relationship :vms, VM, :lazy => true
  #     relationship :media, Media
  #     relationship :extra_data, ExtraData
  #
  class Global < AbstractModel
    # The path to the global VirtualBox XML configuration file. This is
    # entirely system dependent and can be set with {vboxconfig=}. The default
    # is guessed based on the platform.
    @@vboxconfig = nil

    relationship :vms, VM, :lazy => true
    relationship :media, Media
    relationship :extra_data, ExtraData
    relationship :bridged_ifs, BridgedIf, :lazy => true
    relationship :hostonly_ifs, HostOnlyIf, :lazy => true
    @@global_data = nil

    class <<self
      # Retrieves the global data. The return value of this call is cached,
      # and can be reloaded by setting the `reload` parameter to true. Besides
      # explicitly setting the parameter, some actions within the library
      # force global to reload itself on the next call, such as saving a VM,
      # or destroying an image.
      #
      # @param [Boolean] reload True if you want to force a reload of the data.
      # @return [Global]
      def global(reload = false)
        if !@@global_data || reload || reload?
          @@global_data = new(config)
          reloaded!
        end

        @@global_data
      end

      # Sets the path to the VirtualBox.xml file. This file should already
      # exist. VirtualBox itself manages this file, not this library.
      #
      # @param [String] Full path to the VirtualBox.xml file
      def vboxconfig=(value)
        @@vboxconfig = value
      end

      # Returns the path to the virtual box configuration file. If the path
      # has not yet been set, it attempts to infer it based on the
      # platform ruby is running on.
      def vboxconfig
        if @@vboxconfig.nil?
          if Platform.mac?
            @@vboxconfig = "~/Library/VirtualBox/VirtualBox.xml"
          elsif Platform.linux? || Platform.windows?
            @@vboxconfig = "~/.VirtualBox/VirtualBox.xml"
          else
            @@vboxconfig = "Unknown"
          end
        end
        
        File.expand_path(@@vboxconfig)
      end
      
      # Returns a boolean denoting whether or not the vboxconfig value is
      # valid or not.
      #
      # @return [Boolean]
      def vboxconfig?
        File.file?(vboxconfig)
      end

      # Returns the XML document of the configuration. This will raise an
      # {Exceptions::ConfigurationException} if the vboxconfig file doesn't
      # exist.
      #
      # @return [Nokogiri::XML::Document]
      def config
        raise Exceptions::ConfigurationException.new("The path to the global VirtualBox config must be set. See Global.vboxconfig=") unless vboxconfig?
        Command.parse_xml(vboxconfig)
      end

      # Expands path relative to the configuration file.
      #
      # @return [String]
      def expand_path(path)
        File.expand_path(path, File.dirname(vboxconfig))
      end
    end

    def initialize(document)
      @document = document
      populate_attributes(@document)
    end

    def load_relationship(name)
      populate_relationship(name, @document)
    end
    
    def primary_bridged_if
      bridged_ifs.find{ |bridged_interface| bridged_interface.status }
    end
    
    def secondary_bridged_if
      active_ifs = bridged_ifs.find_all{ |bridged_interface| bridged_interface.status }
      if active_ifs.length > 1
        active_ifs[1]
      else
        nil
      end
    end
    
  end
end