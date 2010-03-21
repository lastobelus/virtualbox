module VirtualBox
  module FFI
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

    class IVirtualBox < ::FFI::Struct
      layout :vtbl, :pointer # Pointer to IVirtualBox_vtbl
    end

    class IVirtualBox_vtbl < ::FFI::Struct
      layout  :nsisupports, NSISupports_vtbl,
              :GetVersion, :GetVersion,
              :GetRevision, :GetRevision,
              :GetPackageType, :GetPackageType,
              :GetHomeFolder, :GetHomeFolder,
              :GetSettingsFilePath, :GetSettingsFilePath,
              :GetHost, :GetHost,
              :GetSystemProperties, :GetSystemProperties,
              :GetMachines, :GetMachines,
              :GetHardDisks, :GetHardDisks,
              :GetDVDImages, :GetDVDImages,
              :GetFloppyImages, :GetFloppyImages,
              :GetProgressOperations, :GetProgressOperations,
              :GetGuestOSTypes, :GetGuestOSTypes,
              :GetSharedFolders, :GetSharedFolders,
              :GetPerformanceCollector, :GetPerformanceCollector,
              :GetDHCPServers, :GetDHCPServers,
              :CreateMachine, :CreateMachine,
              :CreateLegacyMachine, :CreateLegacyMachine,
              :OpenMachine, :OpenMachine,
              :RegisterMachine, :RegisterMachine,
              :GetMachine, :GetMachine,
              :FindMachine, :FindMachine,
              :UnregisterMachine, :UnregisterMachine,
              :CreateAppliance, :CreateAppliance,
              :CreateHardDisk, :CreateHardDisk,
              :OpenHardDisk, :OpenHardDisk,
              :GetHardDisk, :GetHardDisk,
              :FindHardDisk, :FindHardDisk,
              :OpenDVDImage, :OpenDVDImage,
              :GetDVDImage, :GetDVDImage,
              :FindDVDImage, :FindDVDImage,
              :OpenFloppyImage, :OpenFloppyImage,
              :GetFloppyImage, :GetFloppyImage,
              :FindFloppyImage, :FindFloppyImage,
              :GetGuestOSType, :GetGuestOSType,
              :CreateSharedFolder, :CreateSharedFolder,
              :RemoveSharedFolder, :RemoveSharedFolder,
              :GetExtraDataKeys, :GetExtraDataKeys,
              :GetExtraData, :GetExtraData,
              :SetExtraData, :SetExtraData,
              :OpenSession, :OpenSession,
              :OpenRemoteSession, :OpenRemoteSession,
              :OpenExistingSession, :OpenExistingSession,
              :RegisterCallback, :RegisterCallback,
              :UnregisterCallback, :UnregisterCallback,
              :WaitForPropertyChange, :WaitForPropertyChange,
              :CreateDHCPServer, :CreateDHCPServer,
              :FindDHCPServerByNetworkName, :FindDHCPServerByNetworkName,
              :RemoveDHCPServer, :RemoveDHCPServer,
              :CheckFirmwarePresent, :CheckFirmwarePresent
    end
  end
end