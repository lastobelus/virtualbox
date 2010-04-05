require 'virtualbox/ext/subclass_listing'
require 'virtualbox/listable'

module VirtualBox
  # An abstract class which encapsulates the shared behaviour of
  # images such as {HardDrive} and {DVD}.
  #
  # ## Attributes
  #
  # All images expose the following attributes. If you don't know how to read
  # this than read {Attributable}.
  #
  #     attribute :uuid, :readonly => true
  #     attribute :location
  #     attribute :accessible, :readonly => true
  #
  # @abstract
  class Image < AbstractModel
    include Listable
    include SubclassListing

    attribute :uuid, :readonly => true
    attribute :location
    attribute :accessible, :readonly => true, :lazy => true

    class <<self

      # Searches the subclasses which implement all method, searching for
      # a matching UUID and returning that as the relationship.
      #
      # **This method typically won't be used except internally.**
      #
      # @return [Array<Image>]
      def populate_relationship(caller, data)
        return DVD.empty_drive if data[:uuid].nil?

        subclasses.each do |subclass|
          next unless subclass.respond_to?(:all)

          matching = subclass.all.find { |obj| obj.uuid == data[:uuid] }
          return matching unless matching.nil?
        end

        nil
      end

      # Sets an image onto a relationship and/or removes it from a
      # relationship. This method is automatically called by {Relatable}.
      #
      # **This method typically won't be used except internally.**
      #
      # @return [Image]
      def set_relationship(caller, old_value, new_value)
        # We don't actually destroy any images using this method,
        # so just return the new value as long as its a valid object
        raise Exceptions::InvalidRelationshipObjectException.new if new_value && !new_value.is_a?(Image)

        return new_value
      end
    end

    # **This should never be called directly on {Image}.** Instead, initialize
    # one of the subclasses.
    def initialize(info=nil)
      super()

      populate_attributes(info) if info
    end

    # The image type as a string for the virtualbox command line. This
    # method should be overridden by any subclass and is expected to
    # return the type which is used in command line parameters for
    # attaching to storage controllers.
    #
    # @return [String]
    def image_type
      raise "This must be implemented by any subclasses"
    end

    # Returns boolean showing if empty drive or not. This method should be
    # overriden by any subclass and is expected to return true of false
    # showing if this image represents an empty drive of whatever type
    # the subclass is.
    #
    # @return [Boolean]
    def empty_drive?
      false
    end

    # Returns the basename of the images location (the file name +extension)
    #
    # @return [String]
    def filename
      File.basename(location.to_s)
    end
  end
end