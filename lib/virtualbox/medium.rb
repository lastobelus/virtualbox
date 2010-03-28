module VirtualBox
  # Represents a medium object part of VirtualBox. A medium is a
  # hard drive, DVD, floppy disk, etc. Each of these share common
  # properties represented here.
  class Medium < AbstractModel
    attribute :uuid, :readonly => :true, :interface_getter => :get_id
    attribute :location, :interface_getter => :get_location
    attribute :state, :interface_getter => :refresh_state

    class <<self
      def populate_relationship(caller, media)
        relation = Proxies::Collection.new(caller)

        media.each do |medium|
          # Skip media this class isn't interested in
          next if device_type != :all && medium.get_device_type != device_type

          # Wrap it up and add to the relationship
          relation << new(medium)
        end

        relation
      end

      # Specifies the device type that a {Medium} class is interested in. This
      # is `:all` on {Medium}, but is expected to be overridden by child classes.
      # The value returned should be one of {FFI::DeviceType}.
      #
      # @return [Symbol]
      def device_type
        :all
      end
    end

    # Initializes a medium object, retrieving the attributes and information
    # from the {FFI::IMedium} object given as the parameter.
    #
    # @param [FFI::IMedium] imedium
    def initialize(imedium)
      load_interface_attributes(imedium)
    end

    # Returns the basename of the images location (the file name +extension)
    #
    # @return [String]
    def filename
      File.basename(location.to_s)
    end
  end
end