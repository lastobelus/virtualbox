module VirtualBox
  # Represents a single VirtualBox virtual machine. All attributes which are
  # not read-only can be modified and saved.
  #
  # # Finding Virtual Machines
  #
  # Two methods are used to find virtual machines: {VM.all} and {VM.find}. Each
  # return a {VM} object. An example is shown below:
  #
  #     vm = VirtualBox::VM.find("MyWindowsXP")
  #     puts vm.name # => "MyWindowsXP"
  #
  # # Modifying Virtual Machines
  #
  # Virtual machines can be modified a lot like [ActiveRecord](http://ar.rubyonrails.org/)
  # objects. This is best shown through example:
  #
  #     vm = VirtualBox::VM.find("MyWindowsXP")
  #     vm.memory = 256
  #     vm.name = "WindowsXP"
  #     vm.save
  #
  # # Attributes and Relationships
  #
  # Properties of the virtual machine are exposed using standard ruby instance
  # methods which are generated on the fly. Because of this, they are not listed
  # below as available instance methods.
  #
  # These attributes can be accessed and modified via standard ruby-style
  # `instance.attribute` and `instance.attribute=` methods. The attributes are
  # listed below.
  #
  # Relationships are also accessed like attributes but can't be set. Instead,
  # they are typically references to other objects such as a {HardDrive} which
  # in turn have their own attributes which can be modified.
  #
  # ## Attributes
  #
  # This is copied directly from the class header, but lists all available
  # attributes. If you don't understand what this means, read {Attributable}.
  #
  #     attribute :uuid, :readonly => true
  #     attribute :name
  #     attribute :ostype
  #     attribute :description, :readonly => true
  #     attribute :memory
  #     attribute :vram
  #     attribute :acpi
  #     attribute :ioapic
  #     attribute :cpus
  #     attribute :synthcpu
  #     attribute :pae
  #     attribute :hwvirtex
  #     attribute :hwvirtexexcl
  #     attribute :nestedpaging
  #     attribute :vtxvpid
  #     attribute :accelerate3d
  #     attribute :accelerate2dvideo
  #     attribute :biosbootmenu, :populate_key => :bootmenu
  #     attribute :boot1
  #     attribute :boot2
  #     attribute :boot3
  #     attribute :boot4
  #     attribute :clipboard
  #     attribute :monitorcount
  #     attribute :usb
  #     attribute :ehci
  #     attribute :audio
  #     attribute :audiocontroller
  #     attribute :audiodriver
  #     attribute :vrdp
  #     attribute :vrdpport
  #     attribute :vrdpauthtype
  #     attribute :vrdpauthtimeout
  #     attribute :state, :populate_key => :vmstate, :readonly => true
  #
  # ## Relationships
  #
  # In addition to the basic attributes, a virtual machine is related
  # to other things. The relationships are listed below. If you don't
  # understand this, read {Relatable}.
  #
  #     relationship :nics, Nic
  #     relationship :usbs, USB
  #     relationship :storage_controllers, StorageController, :dependent => :destroy
  #     relationship :shared_folders, SharedFolder
  #     relationship :extra_data, ExtraData
  #     relationship :forwarded_ports, ForwardedPort
  #
  class VM < AbstractModel
    attribute :uuid, :readonly => true, :interface_getter => :get_id
    attribute :name, :interface_getter => :get_name, :interface_setter => :set_name
    attribute :ostype, :interface_getter => :get_os_type_id, :interface_setter => :set_os_type_id
    attribute :description, :readonly => true, :interface_getter => :get_description, :interface_setter => :set_description
    attribute :memory, :interface_getter => :get_memory_size, :interface_setter => :set_memory_size
    attribute :vram, :interface_getter => :get_vram_size, :interface_setter => :set_vram_size
    attribute :cpus, :interface_getter => :get_cpu_count, :interface_setter => :set_cpu_count
    # TODO (in BIOS settings):
    # attribute :pae
    # attribute :hwvirtex
    # attribute :hwvirtexexcl
    # attribute :nestedpaging
    # attribute :vtxvpid
    attribute :accelerate3d, :interface_getter => :get_accelerate_3d_enabled, :interface_setter => :set_accelerate_3d_enabled
    attribute :accelerate2dvideo, :interface_getter => :get_accelerate_2d_video_enabled, :interface_setter => :set_accelerate_2d_video_enabled
    attribute :clipboard, :interface_getter => :get_clipboard_mode, :interface_setter => :set_clipboard_count
    attribute :monitorcount, :interface_getter => :get_monitor_count, :interface_setter => :set_monitor_count
    # TODO: USB, Audio, VRDP settings
    # attribute :usb
    # attribute :ehci
    # attribute :audio
    # attribute :audiocontroller
    # attribute :audiodriver
    # attribute :vrdp
    # attribute :vrdpport
    # attribute :vrdpauthtype
    # attribute :vrdpauthtimeout
    attribute :state, :readonly => true, :interface_getter => :get_state
    attribute :imachine, :readonly => true
    relationship :bios, BIOS
    # relationship :nics, Nic
    # relationship :usbs, USB
    # relationship :storage_controllers, StorageController, :dependent => :destroy
    # relationship :shared_folders, SharedFolder
    # relationship :extra_data, ExtraData
    # relationship :forwarded_ports, ForwardedPort

    class <<self
      # Returns an array of all available VMs.
      #
      # @return [Array<VM>]
      def all
        Global.global.vms
      end

      # Finds a VM by UUID or registered name and returns a
      # new VM object. If the VM doesn't exist, will return `nil`.
      #
      # @return [VM]
      def find(name)
        all.detect { |o| o.name == name || o.uuid == name }
      end

      # Imports a VM, blocking the entire thread during this time.
      # When finished, on success, will return the VM object. This
      # VM object can be used to make any modifications necessary
      # (RAM, cpus, etc.).
      #
      # @return [VM] The newly imported virtual machine
      def import(source_path)
        # TODO
      end

      def populate_relationship(caller, machines)
        result = Proxies::Collection.new(caller)

        machines.each do |machine|
          result << new(machine)
        end

        result
      end
    end

    # Creates a new instance of a virtual machine.
    #
    # **Currently can NOT be used to create a NEW virtual machine**.
    # Support for creating new virtual machines will be added shortly.
    # For now, this is only used by {VM.find} and {VM.all} to
    # initialize the VMs.
    def initialize(imachine)
      super()

      write_attribute(:imachine, imachine)
      initialize_attributes(imachine)
    end

    def initialize_attributes(machine)
      # Load the interface attributes
      load_interface_attributes(machine)

      # Setup the relationships
      populate_relationships(imachine)

      # Clear dirtiness, since this should only be called initially and
      # therefore shouldn't affect dirtiness
      clear_dirty!

      # But this is an existing record
      existing_record!
    end

    # State of the virtual machine. Returns the state of the virtual
    # machine. This state will represent the state that was assigned
    # when the VM was found unless `reload` is set to `true`.
    #
    # @param [Boolean] reload If true, will reload the state to current
    #   value.
    # @return [String] Virtual machine state.
    def state(reload=false)
      if reload
        load_attribute(:state)
        clear_dirty!(:state)
      end

      read_attribute(:state)
    end

    # Saves the virtual machine if modified. This method saves any modified
    # attributes of the virtual machine. If any related attributes were saved
    # as well (such as storage controllers), those will be saved, too.
    def save
      # Set the session up
      session = Lib.lib.session

      # Open up a session for this virtual machine
      imachine.get_parent.open_session(session, uuid)

      # Use setters to save the attributes on the locked machine and persist
      # the settings
      machine = session.get_machine

      # Save all the attributes and relationships
      save_changed_interface_attributes(machine)
      save_relationships(machine)

      machine.save_settings

      # Close the session
      session.close
    end

    # Exports a virtual machine. The virtual machine will be exported
    # to the specified OVF file name. This directory will also have the
    # `mf` file which contains the file checksums and also the virtual
    # drives of the machine.
    #
    # Export also supports an additional options hash which can contain
    # information that will be embedded with the virtual machine. View
    # below for more information on the available options.
    #
    # This method will block until the export is complete, which takes about
    # 60 to 90 seconds on my 2.2 GHz 2009 model MacBook Pro.
    #
    # @param [String] filename The file (not directory) to save the exported
    #   OVF file. This directory will also receive the checksum file and
    #   virtual disks.
    # @option options [String] :product (nil) The name of the product
    # @option options [String] :producturl (nil) The URL of the product
    # @option options [String] :vendor (nil) The name of the vendor
    # @option options [String] :vendorurl (nil) The URL for the vendor
    # @option options [String] :version (nil) The version information
    # @option options [String] :eula (nil) License text
    # @option options [String] :eulafile (nil) License file
    def export(filename, options={}, raise_error=false)
      # TODO
    end

    # Starts the virtual machine. The virtual machine can be started in a
    # variety of modes:
    #
    # * **gui** -- The VirtualBox GUI will open with the screen of the VM.
    # * **vrdp** -- The VM will run in the background. No GUI will be
    #   present at all.
    #
    # This method blocks while the external processes are starting.
    #
    # @param [Symbol] mode Described above.
    # @return [Boolean] True if command was successful, false otherwise.
    def start(mode="gui")
      return false if running?

      # Open a new remote session, this will automatically start the machine
      # as well
      session = Lib.lib.session
      imachine.get_parent.open_remote_session(session, uuid, mode.to_s, "").wait_for_completion(-1)

      # Close our session to release our lock from the machine
      session.close

      true
    end

    # Shuts down the VM by directly calling "acpipowerbutton". Depending on the
    # settings of the Virtual Machine, this may not work. For example, some linux
    # installations don't respond to the ACPI power button at all. In such cases,
    # {#stop} or {#save_state} may be used instead.
    #
    # @return [Boolean] True if command was successful, false otherwise.
    def shutdown
      control(:power_button)
    end

    # Stops the VM by directly calling "poweroff." Immediately halts the
    # virtual machine without saving state. This could result in a loss
    # of data. To prevent data loss, see {#shutdown}
    #
    # @return [Boolean] True if command was successful, false otherwise.
    def stop(raise_errors=false)
      control(:power_down)
    end

    # Pauses the VM, putting it on hold temporarily. The VM can be resumed
    # again by calling {#resume}
    #
    # @return [Boolean] True if command was successful, false otherwise.
    def pause(raise_errors=false)
      control(:pause)
    end

    # Resume a paused VM.
    #
    # @return [Boolean] True if command was successful, false otherwise.
    def resume(raise_errors=false)
      control(:resume)
    end

    # Saves the state of a VM and stops it. The VM can be resumed
    # again by calling "{#start}" again.
    #
    # @return [Boolean] True if command was successful, false otherwise.
    def save_state(raise_errors=false)
      control(:save_state)
    end

    # Discards any saved state on the current VM. The VM is not destroyed though
    # and can still be started by calling {#start}.
    #
    # @return [Boolean] True if command was successful, false otherwise.
    def discard_state(raise_errors=false)
      control(:forget_saved_state, true)
    end

    # Controls the virtual machine. This method is used by {#stop},
    # {#pause}, {#resume}, and {#save_state} to control the virtual machine.
    # Typically, you won't ever have to call this method and should
    # instead call those.
    #
    # @param [String] command The command to run on controlvm
    # @return [Boolean] True if command was successful, false otherwise.
    def control(command, *args)
      # Grab the session using an existing session
      session = Lib.lib.session
      imachine.get_parent.open_existing_session(session, uuid)

      # Send the proper command, waiting if we have to
      result = session.get_console.send(command, *args)
      result.wait_for_completion(-1) if result.is_a?(FFI::IProgress)

      # Close the session
      session.close
    end

    # Destroys the virtual machine. This method also removes all attached
    # media (required by VirtualBox to destroy a VM). By default,
    # this **will not** destroy attached hard drives, but will if given
    # the `destroy_image` option.
    #
    # @overload destroy(opts = {})
    #   Passes options to the destroy method.
    #   @option opts [Boolean] :destroy_image (false) If true, will
    #     also destroy all attached images such as hard drives, disk
    #     images, etc.
    def destroy(*args)
      # TODO
    end

    # Returns true if the virtual machine state is running
    #
    # @return [Boolean] True if virtual machine state is running
    def running?
      state == :running
    end

    # Returns true if the virtual machine state is powered off
    #
    # @return [Boolean] True if virtual machine state is powered off
    def powered_off?
      state == :powered_off
    end

    # Returns true if the virtual machine state is paused
    #
    # @return [Boolean] True if virtual machine state is paused
    def paused?
      state == :paused
    end

    # Returns true if the virtual machine state is saved
    #
    # @return [Boolean] True if virtual machine state is saved
    def saved?
      state == :saved
    end

    # Returns true if the virtual machine state is aborted
    #
    # @return [Boolean] True if virtual machine state is aborted
    def aborted?
      state == :aborted
    end
  end
end