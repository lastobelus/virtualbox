module VirtualBox
  module COM
    module Interface
      class HostUSBDeviceFilter < AbstractInterface
        IID = "4cc70246-d74a-400f-8222-3900489c0374"

        property :action, :USBDeviceFilterAction
      end
    end
  end
end