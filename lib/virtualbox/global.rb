module VirtualBox
  # Represents the VirtualBox main configuration file (VirtualBox.xml)
  # which VirtualBox uses to keep track of all known virtual machines
  # and images. This "global" configuration has many relationships which
  # allow the user to retrieve a list of all VMs, media, global extra data,
  # etc. Indeed, even methods like {VM.all} are implemented using this class.
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
  #     relationship :vms, VM
  #     relationship :media, Media
  #     relationship :extra_data, ExtraData
  #     relationship :system_properties, :SystemProperties, :lazy => true
  #
  class Global < AbstractModel
    attribute :lib, :readonly => true

    relationship :vms, :VM, :lazy => true
    relationship :media, :Media, :lazy => true
    relationship :extra_data, :ExtraData, :lazy => true
    relationship :system_properties, :SystemProperties, :lazy => true

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
      def global(reload=false)
        if !@@global_data || reload
          @@global_data = new(Lib.lib)
        end

        @@global_data
      end

      # Resets the global data singleton. This is used for testing purposes.
      def reset!
        @@global_data = nil
      end
    end

    def initialize(lib)
      write_attribute(:lib, lib)

      # Required to load lazy relationships
      existing_record!
    end

    def load_relationship(name)
      populate_relationship(:vms, lib.virtualbox.machines)
      populate_relationship(:media, lib)
      populate_relationship(:extra_data, lib.virtualbox)
      populate_relationship(:system_properties, lib.virtualbox.system_properties)
    end
    
    def network_interfaces
      lib.interface.virtualbox.host.network_interfaces
    end
    
    def bridged_network_interfaces
      lib.interface.virtualbox.host.find_host_network_interfaces_of_type(:bridged)
    end

    def host_only_network_interfaces
      lib.interface.virtualbox.host.find_host_network_interfaces_of_type(:host_only)
    end
  end
end