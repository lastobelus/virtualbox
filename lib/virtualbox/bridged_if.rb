require 'virtualbox/listable'

module VirtualBox
  # Represents a single Bridged Interface.
  #
  # **Currently, new Bridged Interfaces can't be created or edited, so the only way to get this
  # object is through the global `bridged_ifs` relationship, and all it's attributes are readonly**
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
  #     attribute :name
  #     attribute :status
  #     attribute :macaddress
  #     attribute :dhcp
  #     attribute :bridgeadapter
  #
  class BridgedIf < AbstractModel
    include Listable
    
    attribute :parent, :readonly => :readonly
    attribute :name, :readonly => :readonly
    attribute :vboxnetworkname, :readonly => :readonly
    attribute :status, :readonly => :readonly
    attribute :dhcp, :readonly => :readonly
    attribute :ipaddress, :readonly => :readonly
    attribute :networkmask, :readonly => :readonly
    attribute :macaddress, :readonly => :readonly, :populate_key => "HardwareAddress"
    attribute :type, :readonly => :readonly, :populate_key => "MediumType"
    
    value_adapter :dhcp, 'Disabled', false
    value_adapter :dhcp, 'Enabled', true
    value_adapter :status, 'Down', false
    value_adapter :status, 'Up', true

    class <<self
      # Populates the bridged_if relationship for anything which is related to it.
      #
      # **This method typically won't be used except internally.**
      #
      # @return [Array<BridgedIf>]
      def populate_relationship(caller, doc)
        relation = Proxies::Collection.new(caller)

        all_from_command.each do |bridged_if|
          relation << bridged_if
        end

        relation
      end

      # Does Nothing
      #
      # **This method typically won't be used except internally.**
      def save_relationship(caller, data)
      end

      # Returns an array of all available DVDs by parsing the VBoxManage
      # output
      def all_from_command
        raw = Command.vboxmanage("list", "bridgedifs")
        parse_raw(raw)
      end

    end

    # Since there is currently no way to create a _new_ bridged_if, this is
    # only used internally. Developers should NOT try to initialize their
    # own bridged_if objects.
    def initialize(info=nil)
      super()

      populate_attributes(info) if info
    end

    # Does Nothing
    # called on {#save}.
    #
    # **This method typically won't be used except internally.**
    def save_attribute(key, value, vmname)
    end
  end
end