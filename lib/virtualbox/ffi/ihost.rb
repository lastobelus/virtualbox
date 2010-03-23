module VirtualBox
  module FFI
    IHOST_IID_STR = "e380cbfc-ae65-4fa6-899e-45ded6b3132a"

    # Function pointers for the IHost_vtbl
    callback :GetDVDDrives, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :GetFloppyDrives, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :GetUSBDevices, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :GetUSBDeviceFilters, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :GetNetworkInterfaces, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :GetProcessorCount, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetProcessorOnlineCount, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetMemorySize, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetMemoryAvailable, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetOperatingSystem, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetOSVersion, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetUTCTime, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetAcceleration3DAvailable, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetProcessorSpeed, [:pointer, PRUint32, :pointer], NSRESULT_TYPE
    callback :GetProcessorFeature, [:pointer, PRUint32, :pointer], NSRESULT_TYPE
    callback :GetProcessorDescription, [:pointer, PRUint32, :pointer], NSRESULT_TYPE
    callback :GetProcessorCpuIdLeaf, [:pointer, PRUint32, PRUint32, PRUint32, :pointer, :pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :CreateHostOnlyNetworkInterface, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :RemoveHostOnlyNetworkInterface, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :CreateUSBDeviceFilter, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :InsertUSBDeviceFilter, [:pointer, PRUint32, :pointer], NSRESULT_TYPE
    callback :RemoveUSBDeviceFilter, [:pointer, PRUint32], NSRESULT_TYPE
    callback :FindHostDVDDrive, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :FindHostFloppyDrive, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :FindHostNetworkInterfaceByName, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :FindHostNetworkInterfaceById, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :FindHostNetworkInterfacesOfType, [:pointer, PRUint32, :pointer, :pointer], NSRESULT_TYPE
    callback :FindUSBDeviceById, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :FindUSBDeviceByAddress, [:pointer, :pointer, :pointer], NSRESULT_TYPE

    class IHost < VTblParent
      parent_of :IHost_vtbl
    end

    class IHost_vtbl < VTbl
      define_layout do
        member :GetDVDDrives, :GetDVDDrives
        member :GetFloppyDrives, :GetFloppyDrives
        member :GetUSBDevices, :GetUSBDevices
        member :GetUSBDeviceFilters, :GetUSBDeviceFilters
        member :GetNetworkInterfaces, :GetNetworkInterfaces
        member :GetProcessorCount, :GetProcessorCount
        member :GetProcessorOnlineCount, :GetProcessorOnlineCount
        member :GetMemorySize, :GetMemorySize
        member :GetMemoryAvailable, :GetMemoryAvailable
        member :GetOperatingSystem, :GetOperatingSystem
        member :GetOSVersion, :GetOSVersion
        member :GetUTCTime, :GetUTCTime
        member :GetAcceleration3DAvailable, :GetAcceleration3DAvailable
        member :GetProcessorSpeed, :GetProcessorSpeed
        member :GetProcessorFeature, :GetProcessorFeature
        member :GetProcessorDescription, :GetProcessorDescription
        member :GetProcessorCpuIdLeaf, :GetProcessorCpuIdLeaf
        member :CreateHostOnlyNetworkInterface, :CreateHostOnlyNetworkInterface
        member :RemoveHostOnlyNetworkInterface, :RemoveHostOnlyNetworkInterface
        member :CreateUSBDeviceFilter, :CreateUSBDeviceFilter
        member :InsertUSBDeviceFilter, :InsertUSBDeviceFilter
        member :RemoveUSBDeviceFilter, :RemoveUSBDeviceFilter
        member :FindHostDVDDrive, :FindHostDVDDrive
        member :FindHostFloppyDrive, :FindHostFloppyDrive
        member :FindHostNetworkInterfaceByName, :FindHostNetworkInterfaceByName
        member :FindHostNetworkInterfaceById, :FindHostNetworkInterfaceById
        member :FindHostNetworkInterfacesOfType, :FindHostNetworkInterfacesOfType
        member :FindUSBDeviceById, :FindUSBDeviceById
        member :FindUSBDeviceByAddress, :FindUSBDeviceByAddress
      end
    end
  end
end
