module VirtualBox
  # Represents a DVD image stored by VirtualBox. These DVD images can be
  # mounted onto virtual machines.
  #
  # # Finding all DVDs
  #
  # The only method at the moment of finding DVDs is to use {DVD.all}, which
  # returns an array of {DVD}s.
  #
  #     DVD.all
  #
  # # Empty Drives
  #
  # Sometimes it is useful to have an empty drive. This is the case where you
  # may have a DVD drive but it has no disk in it. To create an {AttachedDevice},
  # an image _must_ be specified, and an empty drive is a simple option. Creating
  # an empty drive is simple:
  #
  #     DVD.empty_drive
  #
  class DVD < Medium
    class <<self
      # Returns an array of all available DVDs as DVD objects
      def all
        Global.global.media.dvds
      end

      # Override of {Medium.device_type}.
      def device_type
        :dvd
      end
    end
  end
end