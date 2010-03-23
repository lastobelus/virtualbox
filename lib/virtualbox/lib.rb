module VirtualBox
  # Used by the rest of the VirtualBox library to interface with
  # the VirtualBox XPCOM library (VBoxXPCOMC).
  class Lib
    XPCOMC_VERSION = 0x00020000

    @@lib_path = nil
    @@xpcom = nil
    @@vbox = nil
    @@session = nil

    class <<self
      # Resets everything by uninitializing everything. This method forces
      # an {init} call on the next call to any of {xpcom}, {vbox}, or
      # {session}
      def reset!
        @@xpcom = nil
        @@vbox = nil
        @@session = nil
      end

      # The VBOXXPCOMC instance of the {VirtualBox::FFI} which allows interfacing
      # with the VirtualBox XPCOM C interface.
      def xpcom
        init if @@xpcom.nil?
        @@xpcom
      end

      # The IVirtualBox instance of the {VirtualBox::FFI} which allows
      # interfacing with the VirtualBox methods. If the library was not
      # yet initialized, {init} will automatically be called, so it is
      # safe to just begin using this method.
      def vbox
        # If we haven't initialized the library, do so
        init if @@vbox.nil?
        @@vbox
      end

      # The {VirtualBox::FFI::ISession} instance. If the library was not
      # yet initialized, {init} will automatically be called, so it is
      # safe to just begin using this method.
      def session
        init if @@session.nil?
        @@session
      end

      # Sets the path to the VBoxXPCOMC library which is created with any
      # VirtualBox install. 90% of the time, this won't have to be set manually,
      # and instead the gem will try to find it for you.
      #
      # @param [String] Full path to the VBoxXPCOMC library
      def lib_path=(value)
        @@lib_path = value
      end

      # Returns the path to the virtual box library. If the path
      # has not yet been set, it attempts to infer it based on the
      # platform ruby is running on.
      def lib_path
        if @@lib_path.nil?
          if Platform.mac?
            @@lib_path = "/Applications/VirtualBox.app/Contents/MacOS/VBoxXPCOMC.dylib"
          elsif Platform.linux? || Platform.windows?
            @@lib_path = "Unknown"
          else
            @@lib_path = "Unknown"
          end
        end

        File.expand_path(@@lib_path)
      end

      # Initializes the VirtualBox library, setting up access to the
      # {vbox} and {session} variables. Note that by calling these methods,
      # {init} is automatically called if they aren't setup already.
      def init
        # Set the path to the library on the FFI module
        @@xpcom, @@vbox, @@session = VirtualBox::FFI.init(lib_path)
      end
    end
  end
end