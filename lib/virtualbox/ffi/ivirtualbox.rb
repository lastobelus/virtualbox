module VirtualBox
  module FFI
    IVIRTUALBOX_IID_STR = "2158464a-f706-414b-a8c4-fb589dfc6b62"

    # Callback types for IVirtualBox_vtbl
    callback :ivb_GetVersion, [:pointer, :pointer], NSRESULT_TYPE
    callback :ivb_GetRevision, [:pointer, :pointer], NSRESULT_TYPE
    callback :ivb_GetPackageType, [:pointer, :pointer], NSRESULT_TYPE
    callback :ivb_GetHomeFolder, [:pointer, :pointer], NSRESULT_TYPE
    callback :ivb_GetSettingsFilePath, [:pointer, :pointer], NSRESULT_TYPE
    callback :ivb_GetHost, [:pointer, :pointer], NSRESULT_TYPE
    callback :ivb_GetSystemProperties, [:pointer, :pointer], NSRESULT_TYPE
    callback :ivb_GetMachines, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :ivb_GetHardDisks, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :ivb_GetDVDImages, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :ivb_GetFloppyImages, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :ivb_GetProgressOperations, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :ivb_GetGuestOSTypes, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :ivb_GetSharedFolders, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :ivb_GetPerformanceCollector, [:pointer, :pointer], NSRESULT_TYPE
    callback :ivb_GetDHCPServers, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :ivb_CreateMachine, [:pointer, :pointer, :pointer, :pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :ivb_CreateLegacyMachine, [:pointer, :pointer, :pointer, :pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :ivb_OpenMachine, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :ivb_RegisterMachine, [:pointer, :pointer], NSRESULT_TYPE
    callback :ivb_GetMachine, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :ivb_FindMachine, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :ivb_UnregisterMachine, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :ivb_CreateAppliance, [:pointer, :pointer], NSRESULT_TYPE
    callback :ivb_CreateHardDisk, [:pointer, :pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :ivb_OpenHardDisk, [:pointer, :pointer, :pointer, :pointer, :pointer, :pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :ivb_GetHardDisk, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :ivb_FindHardDisk, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :ivb_OpenDVDImage, [:pointer, :pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :ivb_GetDVDImage, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :ivb_FindDVDImage, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :ivb_OpenFloppyImage, [:pointer, :pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :ivb_GetFloppyImage, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :ivb_FindFloppyImage, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :ivb_GetGuestOSType, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :ivb_CreateSharedFolder, [:pointer, :pointer, :pointer, PRBool], NSRESULT_TYPE
    callback :ivb_RemoveSharedFolder, [:pointer, :pointer], NSRESULT_TYPE
    callback :ivb_GetExtraDataKeys, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :ivb_GetExtraData, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :ivb_SetExtraData, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :ivb_OpenSession, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :ivb_OpenRemoteSession, [:pointer, :pointer, :pointer, :pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :ivb_OpenExistingSession, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :ivb_RegisterCallback, [:pointer, :pointer], NSRESULT_TYPE
    callback :ivb_UnregisterCallback, [:pointer, :pointer], NSRESULT_TYPE
    callback :ivb_WaitForPropertyChange, [:pointer, :pointer, :pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :ivb_CreateDHCPServer, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :ivb_FindDHCPServerByNetworkName, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :ivb_RemoveDHCPServer, [:pointer, :pointer], NSRESULT_TYPE
    callback :ivb_CheckFirmwarePresent, [:pointer, :pointer, :pointer, :pointer, :pointer], NSRESULT_TYPE

    class IVirtualBox < VTblParent
      parent_of :IVirtualBox_vtbl
    end

    class IVirtualBox_vtbl < VTbl
      define_layout do
        member :nsisupports, NSISupports_vtbl

        with_opts(:function_type_prefix => :ivb_) do
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
          member :GetProgressOperations, :array_getter, :IProgress
          member :GetGuestOSTypes, :array_getter, :IGuestOSType
          member :GetSharedFolders, :array_getter, :ISharedFolder
          member :GetPerformanceCollector, :getter, :IPerformanceCollector
          member :GetDHCPServers, :array_getter, :IDHCPServer
        end

        member :CreateMachine, :ivb_CreateMachine
        member :CreateLegacyMachine, :ivb_CreateLegacyMachine
        member :OpenMachine, :ivb_OpenMachine
        member :RegisterMachine, :ivb_RegisterMachine
        member :GetMachine, :ivb_GetMachine
        #member :FindMachine, :ivb_FindMachine
        member :FindMachine, :function, [:unicode_string, [:out, :IMachine]], :function_type_prefix => :ivb_
        member :UnregisterMachine, :ivb_UnregisterMachine
        member :CreateAppliance, :ivb_CreateAppliance
        member :CreateHardDisk, :ivb_CreateHardDisk
        member :OpenHardDisk, :ivb_OpenHardDisk
        member :GetHardDisk, :ivb_GetHardDisk
        member :FindHardDisk, :ivb_FindHardDisk
        member :OpenDVDImage, :ivb_OpenDVDImage
        member :GetDVDImage, :ivb_GetDVDImage
        member :FindDVDImage, :ivb_FindDVDImage
        member :OpenFloppyImage, :ivb_OpenFloppyImage
        member :GetFloppyImage, :ivb_GetFloppyImage
        member :FindFloppyImage, :ivb_FindFloppyImage
        member :GetGuestOSType, :ivb_GetGuestOSType
        member :CreateSharedFolder, :ivb_CreateSharedFolder
        member :RemoveSharedFolder, :ivb_RemoveSharedFolder
        member :GetExtraDataKeys, :ivb_GetExtraDataKeys
        member :GetExtraData, :ivb_GetExtraData
        member :SetExtraData, :ivb_SetExtraData
        member :OpenSession, :ivb_OpenSession
        member :OpenRemoteSession, :ivb_OpenRemoteSession
        member :OpenExistingSession, :ivb_OpenExistingSession
        member :RegisterCallback, :ivb_RegisterCallback
        member :UnregisterCallback, :ivb_UnregisterCallback
        member :WaitForPropertyChange, :ivb_WaitForPropertyChange
        member :CreateDHCPServer, :ivb_CreateDHCPServer
        member :FindDHCPServerByNetworkName, :ivb_FindDHCPServerByNetworkName
        member :RemoveDHCPServer, :ivb_RemoveDHCPServer
        member :CheckFirmwarePresent, :ivb_CheckFirmwarePresent
      end
    end
  end
end