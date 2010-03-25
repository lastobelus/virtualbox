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
        member :nsisupports, NSISupports_vtbl
        member :GetDVDDrives, :array_getter, :IMedium
        member :GetFloppyDrives, :array_getter, :IMedium
        member :GetUSBDevices, :array_getter, :IHostUSBDevice
        member :GetUSBDeviceFilters, :array_getter, :IHostUSBDeviceFilter
        member :GetNetworkInterfaces, :GetNetworkInterfaces
        member :GetProcessorCount, :getter, PRUint32
        member :GetProcessorOnlineCount, :getter, PRUint32
        member :GetMemorySize, :getter, PRUint32
        member :GetMemoryAvailable, :getter, PRUint32
        member :GetOperatingSystem, :getter, :unicode_string
        member :GetOSVersion, :getter, :unicode_string
        member :GetUTCTime, :getter, PRInt64
        member :GetAcceleration3DAvailable, :getter, PRBool
        member :GetProcessorSpeed, :function, [PRUint32, [:out, PRUint32]]
        member :GetProcessorFeature, :function, [PRUint32, [:out, PRBool]]
        member :GetProcessorDescription, :function, [PRUint32, [:out, :unicode_string]]
        member :GetProcessorCpuIdLeaf, :function, [PRUint32, PRUint32, PRUint32, [:out, PRUint32], [:out, PRUint32], [:out, PRUint32], [:out, PRUint32]]
        member :CreateHostOnlyNetworkInterface, :CreateHostOnlyNetworkInterface
        member :RemoveHostOnlyNetworkInterface, :function, [:unicode_string, [:out, :IProgress]]
        member :CreateUSBDeviceFilter, :CreateUSBDeviceFilter
        member :InsertUSBDeviceFilter, :InsertUSBDeviceFilter
        member :RemoveUSBDeviceFilter, :function, [PRUint32]
        member :FindHostDVDDrive, :function, [:unicode_string, [:out, :IMedium]]
        member :FindHostFloppyDrive, :function, [:unicode_string, [:out, :IMedium]]
        member :FindHostNetworkInterfaceByName, :FindHostNetworkInterfaceByName
        member :FindHostNetworkInterfaceById, :FindHostNetworkInterfaceById
        member :FindHostNetworkInterfacesOfType, :FindHostNetworkInterfacesOfType
        member :FindUSBDeviceById, :FindUSBDeviceById
        member :FindUSBDeviceByAddress, :FindUSBDeviceByAddress
      end
    end
  end
end
