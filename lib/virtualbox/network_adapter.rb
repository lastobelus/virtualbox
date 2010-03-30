module VirtualBox
  # Represents a single NIC (Network Interface Card) of a virtual machine.
  #
  # **Currently, new NICs can't be created, so the only way to get this
  # object is through a {VM}'s `nics` relationship.**
  #
  # # Editing a NIC
  #
  # Nics can be modified directly in their relationship to other
  # virtual machines. When {VM#save} is called, it will also save any
  # changes to its relationships.
  #
  #     vm = VirtualBox::VM.find("foo")
  #     vm.nics[0].macaddress = @new_mac_address
  #     vm.save
  #
  # # Attributes
  #
  # Properties of the model are exposed using standard ruby instance
  # methods which are generated on the fly. Because of this, they are not listed
  # below as available instance methods.
  #
  # These attributes can be accessed and modified via standard ruby-style
  # `instance.attribute` and `instance.attribute=` methods. The attributes are
  # listed below. If you aren't sure what this means or you can't understand
  # why the below is listed, please read {Attributable}.
  #
  #     attribute :parent, :readonly => :readonly
  #     attribute :nic
  #     attribute :nictype
  #     attribute :macaddress
  #     attribute :cableconnected
  #     attribute :bridgeadapter
  #
  class NetworkAdapter < AbstractModel
    attribute :parent, :readonly => :readonly
    attribute :slot, :readonly => :readonly, :interface_getter => :get_slot
    attribute :enabled, :interface_getter => :get_enabled
    attribute :attachment_type, :interface_getter => :get_attachment_type
    attribute :adapter_type, :interface_getter => :get_adapter_type
    attribute :macaddress, :interface_getter => :get_mac_address
    attribute :cableconnected, :interface_getter => :get_cable_connected

    class <<self
      # Populates the nic relationship for anything which is related to it.
      #
      # **This method typically won't be used except internally.**
      #
      # @return [Array<Nic>]
      def populate_relationship(caller, imachine)
        relation = Proxies::Collection.new(caller)

        # Get the count of network adapters
        count = imachine.get_parent.get_system_properties.get_network_adapter_count

        count.times do |i|
          relation << new(caller, imachine.get_network_adapter(i))
        end

        relation
      end
    end

    def initialize(caller, inetwork)
      super()

      initialize_attributes(caller, inetwork)
    end

    # Initializes the attributes of an existing shared folder.
    def initialize_attributes(parent, inetwork)
      # Set the parent
      write_attribute(:parent, parent)

      # Load the interface attributes
      load_interface_attributes(inetwork)

      # Clear dirtiness, since this should only be called initially and
      # therefore shouldn't affect dirtiness
      clear_dirty!

      # But this is an existing record
      existing_record!
    end
  end
end