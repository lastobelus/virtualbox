module VirtualBox
  # Represents a medium object part of VirtualBox. A medium is a
  # hard drive, DVD, floppy disk, etc. Each of these share common
  # properties represented here.
  class Medium < AbstractModel
    attribute :uuid, :readonly => :true
    attribute :location
    attribute :state

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
      load_attributes(imedium)
    end

    # Loads the attributes from an IMedium object.
    #
    # @param [FFI::IMedium] imedium
    def load_attributes(imedium)
      attr_map = attribute_map
      attr_map.each do |key, value|
        attr_map[key] = imedium.send(value)
      end

      populate_attributes(attr_map)
    end

    # Returns a hash representing the mapping between an attribute name and
    # the method on the IMedium used to retrieve the value of that attribute.
    #
    # @return [Hash]
    def attribute_map
      {
        :uuid => :get_id,
        :location => :get_location,
        :state => :refresh_state
      }
    end

    # Returns the basename of the images location (the file name +extension)
    #
    # @return [String]
    def filename
      File.basename(location.to_s)
    end
  end
end