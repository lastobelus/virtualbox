module VirtualBox
  module FFI
    ISYSTEMPROPERTIES_IID_STR = "8030645c-8fef-4320-bb7b-c829f00069dc"

    # Callbacks for ISystemProperties_vtbl
    callback :GetMinGuestRAM, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetMaxGuestRAM, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetMinGuestVRAM, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetMaxGuestVRAM, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetMinGuestCPUCount, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetMaxGuestCPUCount, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetMaxVDISize, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetNetworkAdapterCount, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetSerialPortCount, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetParallelPortCount, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetMaxBootPosition, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetDefaultMachineFolder, [:pointer, :pointer], NSRESULT_TYPE
    callback :SetDefaultMachineFolder, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetDefaultHardDiskFolder, [:pointer, :pointer], NSRESULT_TYPE
    callback :SetDefaultHardDiskFolder, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetMediumFormats, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :GetDefaultHardDiskFormat, [:pointer, :pointer], NSRESULT_TYPE
    callback :SetDefaultHardDiskFormat, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetRemoteDisplayAuthLibrary, [:pointer, :pointer], NSRESULT_TYPE
    callback :SetRemoteDisplayAuthLibrary, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetWebServiceAuthLibrary, [:pointer, :pointer], NSRESULT_TYPE
    callback :SetWebServiceAuthLibrary, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetLogHistoryCount, [:pointer, :pointer], NSRESULT_TYPE
    callback :SetLogHistoryCount, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetDefaultAudioDriver, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetMaxDevicesPerPortForStorageBus, [:pointer, PRUint32, :pointer], NSRESULT_TYPE
    callback :GetMinPortCountForStorageBus, [:pointer, PRUint32, :pointer], NSRESULT_TYPE
    callback :GetMaxPortCountForStorageBus, [:pointer, PRUint32, :pointer], NSRESULT_TYPE
    callback :GetMaxInstancesOfStorageBus, [:pointer, PRUint32, :pointer], NSRESULT_TYPE
    callback :GetDeviceTypesForStorageBus, [:pointer, PRUint32, :pointer, :pointer], NSRESULT_TYPE

    class ISystemProperties < VTblParent
      parent_of :ISystemProperties_vtbl
    end

    class ISystemProperties_vtbl < VTbl
      define_layout do
        member :nsisupports, NSISupports_vtbl
        member :GetMinGuestRAM, :getter, PRUint32
        member :GetMaxGuestRAM, :getter, PRUint32
        member :GetMinGuestVRAM, :getter, PRUint32
        member :GetMaxGuestVRAM, :getter, PRUint32
        member :GetMinGuestCPUCount, :getter, PRUint32
        member :GetMaxGuestCPUCount, :getter, PRUint32
        member :GetMaxVDISize, :getter, PRUint64
        member :GetNetworkAdapterCount, :getter, PRUint32
        member :GetSerialPortCount, :getter, PRUint32
        member :GetParallelPortCount, :getter, PRUint32
        member :GetMaxBootPosition, :getter, PRUint32
        member :GetDefaultMachineFolder, :getter, :unicode_string
        member :SetDefaultMachineFolder, :SetDefaultMachineFolder
        member :GetDefaultHardDiskFolder, :getter, :unicode_string
        member :SetDefaultHardDiskFolder, :SetDefaultHardDiskFolder
        member :GetMediumFormats, :GetMediumFormats
        member :GetDefaultHardDiskFormat, :getter, :unicode_string
        member :SetDefaultHardDiskFormat, :SetDefaultHardDiskFormat
        member :GetRemoteDisplayAuthLibrary, :getter, :unicode_string
        member :SetRemoteDisplayAuthLibrary, :SetRemoteDisplayAuthLibrary
        member :GetWebServiceAuthLibrary, :getter, :unicode_string
        member :SetWebServiceAuthLibrary, :SetWebServiceAuthLibrary
        member :GetLogHistoryCount, :getter, PRUint32
        member :SetLogHistoryCount, :SetLogHistoryCount
        member :GetDefaultAudioDriver, :getter, PRUint32
        member :GetMaxDevicesPerPortForStorageBus, :GetMaxDevicesPerPortForStorageBus
        member :GetMinPortCountForStorageBus, :GetMinPortCountForStorageBus
        member :GetMaxPortCountForStorageBus, :GetMaxPortCountForStorageBus
        member :GetMaxInstancesOfStorageBus, :GetMaxInstancesOfStorageBus
        member :GetDeviceTypesForStorageBus, :GetDeviceTypesForStorageBus
      end
    end
  end
end
