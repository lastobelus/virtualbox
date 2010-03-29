module VirtualBox
  module FFI
    ISTORAGECONTROLLER_IID_STR = "6bf8335b-d14a-44a5-9b45-ddc49ce7d5b2"

    # Callbacks for IStorageController_vtbl
    callback :isc_GetName, [:pointer, :pointer], NSRESULT_TYPE
    callback :isc_GetMaxDevicesPerPortCount, [:pointer, :pointer], NSRESULT_TYPE
    callback :isc_GetMinPortCount, [:pointer, :pointer], NSRESULT_TYPE
    callback :isc_GetMaxPortCount, [:pointer, :pointer], NSRESULT_TYPE
    callback :isc_GetInstance, [:pointer, :pointer], NSRESULT_TYPE
    callback :isc_SetInstance, [:pointer, PRUint32], NSRESULT_TYPE
    callback :isc_GetPortCount, [:pointer, :pointer], NSRESULT_TYPE
    callback :isc_SetPortCount, [:pointer, PRUint32], NSRESULT_TYPE
    callback :isc_GetBus, [:pointer, :pointer], NSRESULT_TYPE
    callback :isc_GetControllerType, [:pointer, :pointer], NSRESULT_TYPE
    callback :isc_SetControllerType, [:pointer, PRUint32], NSRESULT_TYPE
    callback :isc_GetIDEEmulationPort, [:pointer, PRInt32, :pointer], NSRESULT_TYPE
    callback :isc_SetIDEEmulationPort, [:pointer, PRInt32, PRInt32], NSRESULT_TYPE

    class StorageBus < Enum
      map [:null, :ide, :sata, :scsi, :floppy]
    end

    class StorageControllerType < Enum
      map [:null, :lsi_logic, :bus_logic, :intel_ahci, :piix3, :piix4, :ich6, :i82078]
    end

    class IStorageController < VTblParent
      parent_of :IStorageController_vtbl
    end

    class IStorageController_vtbl < VTbl
      define_layout do
        member :nsisupports, NSISupports_vtbl

        with_opts(:function_type_prefix => :isc_) do
          member :GetName, :getter, :unicode_string
          member :GetMaxDevicesPerPortCount, :getter, PRUint32
          member :GetMinPortCount, :getter, PRUint32
          member :GetMaxPortCount, :getter, PRUint32
          member :GetInstance, :getter, PRUint32
          member :SetInstance, :function, [PRUint32]
          member :GetPortCount, :getter, PRUint32
          member :SetPortCount, :function, [PRUint32]
          member :GetBus, :getter, :StorageBus
          member :GetControllerType, :getter, :StorageControllerType
          member :SetControllerType, :function, [:StorageControllerType]
          member :GetIDEEmulationPort, :function, [PRInt32, [:out, PRInt32]]
          member :SetIDEEmulationPort, :function, [PRInt32, PRInt32]
        end
      end
    end
  end
end