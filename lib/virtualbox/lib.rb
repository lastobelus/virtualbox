module VirtualBox
  # Used by the rest of the VirtualBox library to interface with
  # the VirtualBox XPCOM library (VBoxXPCOMC).
  class Lib
    XPCOMC_VERSION = 0x00020000

    @@lib_path = nil
    @@lib = nil

    attr_reader :xpcom, :vbox, :session

    class <<self
      # Resets the initialized library (if there is any). This is primarily only
      # used for testing.
      def reset!
        @@lib = nil
      end

      # The singleton instance of Lib.
      #
      # @return [Lib]
      def lib
        @@lib ||= new(lib_path)
      end

      # Sets the path to the VBoxXPCOMC library which is created with any
      # VirtualBox install. 90% of the time, this won't have to be set manually,
      # and instead the gem will try to find it for you.
      #
      # @param [String] Full path to the VBoxXPCOMC library
      def lib_path=(value)
        @@lib_path = value.nil? ? value : File.expand_path(value)
      end

      # Returns the path to the virtual box library. If the path
      # has not yet been set, it attempts to infer it based on the
      # platform ruby is running on.
      def lib_path
        if @@lib_path.nil?
          if Platform.mac?
            @@lib_path = ["/Applications/VirtualBox.app/Contents/MacOS/VBoxXPCOMC.dylib"]
          elsif Platform.linux?
            @@lib_path = ["/opt/VirtualBox/VBoxXPCOMC.so", "/usr/lib/virtualbox/VBoxXPCOMC.so"]
          elsif Platform.windows?
            @@lib_path = "Unknown"
          else
            @@lib_path = "Unknown"
          end
        end

        @@lib_path
      end
    end

    def initialize(lib_path)
      @xpcom, @vbox, @session = VirtualBox::FFI.init(lib_path)
    end
  end
end