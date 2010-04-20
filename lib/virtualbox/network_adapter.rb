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
    attribute :parent, :readonly => true, :property => false
    attribute :slot, :readonly => true
    attribute :enabled
    attribute :attachment_type
    attribute :adapter_type
    attribute :mac_address
    attribute :cable_connected
    attribute :nat_network
    attribute :internal_network
    attribute :host_interface
    attribute :interface, :readonly => true, :property => false

    class <<self
      # Populates the nic relationship for anything which is related to it.
      #
      # **This method typically won't be used except internally.**
      #
      # @return [Array<Nic>]
      def populate_relationship(caller, imachine)
        relation = Proxies::Collection.new(caller)

        # Get the count of network adapters
        count = imachine.parent.system_properties.network_adapter_count

        count.times do |i|
          relation << new(caller, imachine.get_network_adapter(i))
        end

        relation
      end

      # Saves the relationship. This simply calls {#save} on every
      # member of the relationship.
      #
      # **This method typically won't be used except internally.**
      def save_relationship(caller, items)
        items.each do |item|
          item.save
        end
      end
    end

    def initialize(caller, inetwork)
      super()

      initialize_attributes(caller, inetwork)
    end

    # Initializes the attributes of an existing shared folder.
    def initialize_attributes(parent, inetwork)
      # Set the parent and interface
      write_attribute(:parent, parent)
      write_attribute(:interface, inetwork)

      # Load the interface attributes
      load_interface_attributes(inetwork)

      # Clear dirtiness, since this should only be called initially and
      # therefore shouldn't affect dirtiness
      clear_dirty!

      # But this is an existing record
      existing_record!
    end

    # Save a network adapter.
    def save
      modify_adapter do |adapter|
        save_attachment_type(adapter)
        save_changed_interface_attributes(adapter)
      end
    end

    # Saves the attachment type. This should never be called directly. Instead,
    # {save} should be called, which will call this method if appropriate.
    def save_attachment_type(adapter)
      return unless attachment_type_changed?

      mapping = {
        :nat => :attach_to_nat,
        :bridged => :attach_to_bridged_interface,
        :internal => :attach_to_internal_network,
        :host_only => :attach_to_host_only_interface
      }

      adapter.send(mapping[attachment_type])
      clear_dirty!(:attachment_type)
    end

    def attach_to_nat_interface
      self.attachment_type = :nat
      self.enabled = true
    end
    
    # attaches the network adapter to an internal network. By default, it  will
    # attach to the default internal network that VirtualBox creates, which is 
    # called "intnet". To attach to a different internal network, pass its name
    def attach_to_internal_network(name="intnet")
      # couldn't find a way to get VirtualBox to list internal networks over FFI
      self.attachment_type = :internal_network
      self.internal_network = name
      self.enabled = true
    end
    
    # attaches the networks adapter to a host_only network. By default it will
    # attach to the first host_only interface in the global list (this is normally
    # "vboxnet0")
    def attach_to_host_only_interface(name=nil)
      ho_ifs = VirtualBox::Global.global.host_only_network_interfaces
      if name.nil?
        name = ho_ifs.first.name unless ho_ifs.empty?
      else
        logger.warn("attach_to_host_only_interface: Host interface named #{name} either does not exist or is not a host-only interface") if( ho_ifs.empty? || ho_ifs.none?{|i| i.name == name} )            
      end
      self.host_interface = name if name
      self.attachment_type = :host_only
      self.enabled = true
    end
    
    def attach_to_bridged_interface(name=nil)
      br_ifs = VirtualBox::Global.global.bridged_network_interfaces_network_interfaces
      if name.nil?
        name = br_ifs.first.name unless br_ifs.empty?
      else
        logger.warn("attach_to_host_only_interface: Host interface named #{name} either does not exist or is not a bridged interface") if( br_ifs.empty? || br_ifs.none?{|i| i.name == name} )            
      end

      self.host_interface = name if name
      self.attachment_type = :bridged
      self.enabled = true
    end
    
    # Opens a session, yields the adapter and then saves the machine at
    # the end
    def modify_adapter
      parent.with_open_session do |session|
        machine = session.machine
        yield machine.get_network_adapter(slot)
      end
    end
  end
end