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
          member :CreateMachine, :function, [:unicode_string, :unicode_string, :unicode_string, :unicode_string, [:out, :IMachine]]
          member :CreateLegacyMachine, :function, [:unicode_string, :unicode_string, :unicode_string, :unicode_string, [:out, :IMachine]]
          member :OpenMachine, :function, [:unicode_string, [:out, :IMachine]]
          member :RegisterMachine, :function, [:IMachine]
          member :GetMachine, :function, [:unicode_string, [:out, :IMachine]]
          member :FindMachine, :function, [:unicode_string, [:out, :IMachine]]
          member :UnregisterMachine, :function, [:unicode_string, [:out, :IMachine]]
          member :CreateAppliance, :function, [[:out, :IAppliance]]
          member :CreateHardDisk, :function, [:unicode_string, :unicode_string, [:out, :IMedium]]
          member :OpenHardDisk, :function, [:unicode_string, PRUint32, PRBool, :unicode_string, PRBool, :unicode_string, [:out, :IMedium]]
          member :GetHardDisk, :function, [:unicode_string, [:out, :IMedium]]
          member :FindHardDisk, :function, [:unicode_string, [:out, :IMedium]]
          member :OpenDVDImage, :function, [:unicode_string, :unicode_string, [:out, :IMedium]]
          member :GetDVDImage, :function, [:unicode_string, [:out, :IMedium]]
          member :FindDVDImage, :function, [:unicode_string, [:out, :IMedium]]
          member :OpenFloppyImage, :function, [:unicode_string, :unicode_string, [:out, :IMedium]]
          member :GetFloppyImage, :function, [:unicode_string, [:out, :IMedium]]
          member :FindFloppyImage, :function, [:unicode_string, [:out, :IMedium]]
          member :GetGuestOSType, :function, [:unicode_string, [:out, :IGuestOSType]]
          member :CreateSharedFolder, :function, [:unicode_string, :unicode_string, PRBool]
          member :RemoveSharedFolder, :function, [:unicode_string]
          member :GetExtraDataKeys, :array_getter, :unicode_string
          member :GetExtraData, :function, [:unicode_string, [:out, :unicode_string]]
          member :SetExtraData, :function, [:unicode_string, :unicode_string]
          member :OpenSession, :function, [:ISession, :unicode_string]
          member :OpenRemoteSession, :function, [:ISession, :unicode_string, :unicode_string, :unicode_string, [:out, :IProgress]]
          member :OpenExistingSession, :function, [:ISession, :unicode_string]
        end

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