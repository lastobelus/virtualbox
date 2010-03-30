module VirtualBox
  # Represents the attachment of a medium (DVD, Hard Drive, etc) to a
  # virtual machine, and specifically to a {StorageController}.
  class MediumAttachment < AbstractModel
    attribute :parent, :readonly => true
    attribute :controller_name, :readonly => :true, :interface_getter => :get_controller
    attribute :port, :readonly => true, :interface_getter => :get_port
    attribute :device_slot, :readonly => true, :interface_getter => :get_device
    attribute :passthrough, :readonly => true, :interface_getter => :get_passthrough
    attribute :type, :readonly => true, :interface_getter => :get_type
    relationship :medium, :Medium
    relationship :storage_controller, :StorageController

    class <<self
      # Populates a relationship with another model.
      #
      # **This method typically won't be used except internally.**
      #
      # @return [Array<MediumAttachment>]
      def populate_relationship(caller, imachine)
        relation = Proxies::Collection.new(caller)

        imachine.get_medium_attachments.each do |ima|
          relation << new(caller, ima)
        end

        relation
      end
    end

    def initialize(parent, imedium_attachment)
      populate_attributes({:parent => parent}, :ignore_relationships => true)
      load_interface_attributes(imedium_attachment)
      populate_relationship(:medium, imedium_attachment.get_medium)
      populate_relationship(:storage_controller, self)
    end

    # Detaches the medium from it's parent virtual machine. Note that this
    # **does not delete** the `medium` which this attachment references; it
    # merely removes the assocation of said medium with this attachment's
    # virtual machine.
    def detach
      # TODO: Need storage controller relationship!
      # parent.interface.detach_device("TODO", port, device_slot)
    end
  end
end