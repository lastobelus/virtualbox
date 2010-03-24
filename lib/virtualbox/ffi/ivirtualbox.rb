module VirtualBox
  module FFI
    IVIRTUALBOX_IID_STR = "2158464a-f706-414b-a8c4-fb589dfc6b62"

    # Callback types for IVirtualBox_vtbl
    callback :GetVersion, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetRevision, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetPackageType, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetHomeFolder, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetSettingsFilePath, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetHost, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetSystemProperties, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetMachines, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :GetHardDisks, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :GetDVDImages, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :GetFloppyImages, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :GetProgressOperations, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :GetGuestOSTypes, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :GetSharedFolders, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :GetPerformanceCollector, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetDHCPServers, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :CreateMachine, [:pointer, :pointer, :pointer, :pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :CreateLegacyMachine, [:pointer, :pointer, :pointer, :pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :OpenMachine, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :RegisterMachine, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetMachine, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :FindMachine, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :UnregisterMachine, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :CreateAppliance, [:pointer, :pointer], NSRESULT_TYPE
    callback :CreateHardDisk, [:pointer, :pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :OpenHardDisk, [:pointer, :pointer, :pointer, :pointer, :pointer, :pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :GetHardDisk, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :FindHardDisk, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :OpenDVDImage, [:pointer, :pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :GetDVDImage, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :FindDVDImage, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :OpenFloppyImage, [:pointer, :pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :GetFloppyImage, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :FindFloppyImage, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :GetGuestOSType, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :CreateSharedFolder, [:pointer, :pointer, :pointer, PRBool], NSRESULT_TYPE
    callback :RemoveSharedFolder, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetExtraDataKeys, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :GetExtraData, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :SetExtraData, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :OpenSession, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :OpenRemoteSession, [:pointer, :pointer, :pointer, :pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :OpenExistingSession, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :RegisterCallback, [:pointer, :pointer], NSRESULT_TYPE
    callback :UnregisterCallback, [:pointer, :pointer], NSRESULT_TYPE
    callback :WaitForPropertyChange, [:pointer, :pointer, :pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :CreateDHCPServer, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :FindDHCPServerByNetworkName, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :RemoveDHCPServer, [:pointer, :pointer], NSRESULT_TYPE
    callback :CheckFirmwarePresent, [:pointer, :pointer, :pointer, :pointer, :pointer], NSRESULT_TYPE

    class IVirtualBox < VTblParent
      parent_of :IVirtualBox_vtbl
    end

    class IVirtualBox_vtbl < VTbl
      define_layout do
        member :nsisupports, NSISupports_vtbl
        member :GetVersion, :getter, :unicode_string
        member :GetRevision, :getter, :uint
        member :GetPackageType, :getter, :unicode_string
        member :GetHomeFolder, :getter, :unicode_string
        member :GetSettingsFilePath, :getter, :unicode_string
        member :GetHost, :getter, :IHost
        member :GetSystemProperties, :getter, :ISystemProperties
        member :GetMachines, :array_getter, :IMachine
        member :GetHardDisks, :array_getter, :IMedium
        member :GetDVDImages, :array_getter, :IMedium
        member :GetFloppyImages, :array_getter, :IMedium
        member :GetProgressOperations, :GetProgressOperations
        member :GetGuestOSTypes, :GetGuestOSTypes
        member :GetSharedFolders, :GetSharedFolders
        member :GetPerformanceCollector, :GetPerformanceCollector
        member :GetDHCPServers, :GetDHCPServers
        member :CreateMachine, :CreateMachine
        member :CreateLegacyMachine, :CreateLegacyMachine
        member :OpenMachine, :OpenMachine
        member :RegisterMachine, :RegisterMachine
        member :GetMachine, :GetMachine
        member :FindMachine, :FindMachine
        member :UnregisterMachine, :UnregisterMachine
        member :CreateAppliance, :CreateAppliance
        member :CreateHardDisk, :CreateHardDisk
        member :OpenHardDisk, :OpenHardDisk
        member :GetHardDisk, :GetHardDisk
        member :FindHardDisk, :FindHardDisk
        member :OpenDVDImage, :OpenDVDImage
        member :GetDVDImage, :GetDVDImage
        member :FindDVDImage, :FindDVDImage
        member :OpenFloppyImage, :OpenFloppyImage
        member :GetFloppyImage, :GetFloppyImage
        member :FindFloppyImage, :FindFloppyImage
        member :GetGuestOSType, :GetGuestOSType
        member :CreateSharedFolder, :CreateSharedFolder
        member :RemoveSharedFolder, :RemoveSharedFolder
        member :GetExtraDataKeys, :GetExtraDataKeys
        member :GetExtraData, :GetExtraData
        member :SetExtraData, :SetExtraData
        member :OpenSession, :OpenSession
        member :OpenRemoteSession, :OpenRemoteSession
        member :OpenExistingSession, :OpenExistingSession
        member :RegisterCallback, :RegisterCallback
        member :UnregisterCallback, :UnregisterCallback
        member :WaitForPropertyChange, :WaitForPropertyChange
        member :CreateDHCPServer, :CreateDHCPServer
        member :FindDHCPServerByNetworkName, :FindDHCPServerByNetworkName
        member :RemoveDHCPServer, :RemoveDHCPServer
        member :CheckFirmwarePresent, :CheckFirmwarePresent
      end
    end
  end
end