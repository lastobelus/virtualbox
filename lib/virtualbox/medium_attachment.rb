module VirtualBox
  # Represents the attachment of a medium (DVD, Hard Drive, etc) to a
  # virtual machine, and specifically to a {StorageController}.
  class MediumAttachment < AbstractModel
    attribute :parent, :readonly => true
    attribute :port, :readonly => true, :interface_getter => :get_port
    attribute :passthrough, :readonly => true, :interface_getter => :get_passthrough
    attribute :type, :readonly => true, :interface_getter => :get_type
    relationship :medium, Medium

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
    end
  end
end