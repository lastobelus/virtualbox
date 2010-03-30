module VirtualBox
  # Represents a medium object part of VirtualBox. A medium is a
  # hard drive, DVD, floppy disk, etc. Each of these share common
  # properties represented here.
  class Medium < AbstractModel
    include SubclassListing

    attribute :uuid, :readonly => :true, :interface_getter => :get_id
    attribute :location, :interface_getter => :get_location
    attribute :state, :interface_getter => :refresh_state

    class <<self
      # Populates a relationship with another model. Depending on the data sent
      # through as the `media` parameter, this can either return a single value
      # or an array of values. {Global}, for example, has a relationship of media,
      # while a {MediumAttachment} has a relationship with a single medium.
      #
      # **This method typically won't be used except internally.**
      def populate_relationship(caller, media)
        if media.is_a?(Array)
          # has many relationship
          populate_array_relationship(caller, media)
        else
          # has one relationship
          populate_single_relationship(caller, media)
        end
      end

      # Populates a relationship which has many media.
      #
      # **This method typically won't be used except internally.**
      #
      # @return [Array<Medium>]
      def populate_array_relationship(caller, media)
        relation = Proxies::Collection.new(caller)

        media.each do |medium|
          # Skip media this class isn't interested in
          next if device_type != :all && medium.get_device_type != device_type

          # Wrap it up and add to the relationship
          relation << new(medium)
        end

        relation
      end

      # Populates a relationship which has one medium. This method goes one step
      # further and instantiates the proper class for the type of medium given.
      # For example, given a `device_type` of `:hard_drive`, it would return a
      # {HardDrive} object.
      #
      # **This method typically won't be used except internally.**
      #
      # @return [Medium]
      def populate_single_relationship(caller, medium)
        return nil if medium.nil?

        subclasses.each do |subclass|
          # Skip this class unless the device type matches
          next unless subclass.device_type == medium.get_device_type

          # Wrap it up and return it
          return subclass.new(medium)
        end

        # If all else fails, just wrap it in a Medium
        new(medium)
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