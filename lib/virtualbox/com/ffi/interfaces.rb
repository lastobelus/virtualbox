module VirtualBox
  module COM
    module FFI
      # Creates all the interfaces for the FFI implementation. Eventually this
      # file should be conditionally loaded based on OS, so that Windows users
      # don't have to wait for all this translation to occur.
      create_interface(:NSISupports)
      create_interface(:NSIException, :NSISupports)
      create_interface(:Session, :NSISupports)
      create_interface(:VirtualBox, :NSISupports)
      create_interface(:Appliance, :NSISupports)
      create_interface(:AudioAdapter, :NSISupports)
      create_interface(:BIOSSettings, :NSISupports)
      create_interface(:Console, :NSISupports)
      create_interface(:DHCPServer, :NSISupports)
      create_interface(:GuestOSType, :NSISupports)
      create_interface(:Host, :NSISupports)
      create_interface(:HostNetworkInterface, :NSISupports)
      create_interface(:Machine, :NSISupports)
      create_interface(:Medium, :NSISupports)
      create_interface(:MediumAttachment, :NSISupports)
      create_interface(:MediumFormat, :NSISupports)
      create_interface(:NetworkAdapter, :NSISupports)
      create_interface(:ParallelPort, :NSISupports)
      create_interface(:Progress, :NSISupports)
      create_interface(:SerialPort, :NSISupports)
      create_interface(:SharedFolder, :NSISupports)
      create_interface(:Snapshot, :NSISupports)
      create_interface(:StorageController, :NSISupports)
      create_interface(:SystemProperties, :NSISupports)
      create_interface(:USBController, :NSISupports)
      create_interface(:USBDevice, :NSISupports)
      create_interface(:USBDeviceFilter, :NSISupports)
      create_interface(:VirtualBoxErrorInfo, :NSIException)
      create_interface(:VirtualSystemDescription, :NSISupports)
      create_interface(:VRDPServer, :NSISupports)

      create_interface(:HostUSBDevice, :USBDevice)
      create_interface(:HostUSBDeviceFilter, :USBDeviceFilter)
    end
  end
end