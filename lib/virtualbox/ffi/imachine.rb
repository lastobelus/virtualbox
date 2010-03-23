module VirtualBox
  module FFI
    IMACHINE_IID_STR = "99404f50-dd10-40d3-889b-dd2f79f1e95e"

    # Callback types for IMachine_vtbl
    callback :GetParent, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetAccessible, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetAccessError, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetName, [:pointer, :pointer], NSRESULT_TYPE
    callback :SetName, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetDescription, [:pointer, :pointer], NSRESULT_TYPE
    callback :SetDescription, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetId, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetOSTypeId, [:pointer, :pointer], NSRESULT_TYPE
    callback :SetOSTypeId, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetHardwareVersion, [:pointer, :pointer], NSRESULT_TYPE
    callback :SetHardwareVersion, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetHardwareUUID, [:pointer, :pointer], NSRESULT_TYPE
    callback :SetHardwareUUID, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetCPUCount, [:pointer, :pointer], NSRESULT_TYPE
    callback :SetCPUCount, [:pointer, PRUint32], NSRESULT_TYPE
    callback :GetMemorySize, [:pointer, :pointer], NSRESULT_TYPE
    callback :SetMemorySize, [:pointer, PRUint32], NSRESULT_TYPE
    callback :GetMemoryBalloonSize, [:pointer, :pointer], NSRESULT_TYPE
    callback :SetMemoryBalloonSize, [:pointer, PRUint32], NSRESULT_TYPE
    callback :GetStatisticsUpdateInterval, [:pointer, :pointer], NSRESULT_TYPE
    callback :SetStatisticsUpdateInterval, [:pointer, PRUint32], NSRESULT_TYPE
    callback :GetVRAMSize, [:pointer, :pointer], NSRESULT_TYPE
    callback :SetVRAMSize, [:pointer, PRUint32], NSRESULT_TYPE
    callback :GetAccelerate3DEnabled, [:pointer, :pointer], NSRESULT_TYPE
    callback :SetAccelerate3DEnabled, [:pointer, PRBool], NSRESULT_TYPE
    callback :GetAccelerate2DVideoEnabled, [:pointer, :pointer], NSRESULT_TYPE
    callback :SetAccelerate2DVideoEnabled, [:pointer, PRBool], NSRESULT_TYPE
    callback :GetMonitorCount, [:pointer, :pointer], NSRESULT_TYPE
    callback :SetMonitorCount, [:pointer, PRUint32], NSRESULT_TYPE
    callback :GetBIOSSettings, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetFirmwareType, [:pointer, :pointer], NSRESULT_TYPE
    callback :SetFirmwareType, [:pointer, PRUint32], NSRESULT_TYPE
    callback :GetSnapshotFolder, [:pointer, :pointer], NSRESULT_TYPE
    callback :SetSnapshotFolder, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetVRDPServer, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetMediumAttachments, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :GetUSBController, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetAudioAdapter, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetStorageControllers, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :GetSettingsFilePath, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetSettingsModified, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetSessionState, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetSessionType, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetSessionPid, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetState, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetLastStateChange, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetStateFilePath, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetLogFolder, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetCurrentSnapshot, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetSnapshotCount, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetCurrentStateModified, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetSharedFolders, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetClipboardMode, [:pointer, :pointer], NSRESULT_TYPE
    callback :SetClipboardMode, [:pointer, PRUint32], NSRESULT_TYPE
    callback :GetGuestPropertyNotificationPatterns, [:pointer, :pointer], NSRESULT_TYPE
    callback :SetGuestPropertyNotificationPatterns, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetTeleporterEnabled, [:pointer, :pointer], NSRESULT_TYPE
    callback :SetTeleporterEnabled, [:pointer, PRBool], NSRESULT_TYPE
    callback :GetTeleporterPort, [:pointer, :pointer], NSRESULT_TYPE
    callback :SetTeleporterPort, [:pointer, PRUint32], NSRESULT_TYPE
    callback :GetTeleporterAddress, [:pointer, :pointer], NSRESULT_TYPE
    callback :SetTeleporterAddress, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetTeleporterPassword, [:pointer, :pointer], NSRESULT_TYPE
    callback :SetTeleporterPassword, [:pointer, :pointer], NSRESULT_TYPE
    callback :SetBootOrder, [:pointer, PRUint32, PRUint32], NSRESULT_TYPE
    callback :GetBootOrder, [:pointer, PRUint32, :pointer], NSRESULT_TYPE
    callback :AttachDevice, [:pointer, :pointer, PRInt32, PRInt32, PRUint32, :pointer], NSRESULT_TYPE
    callback :DetachDevice, [:pointer, :pointer, PRInt32, PRInt32], NSRESULT_TYPE
    callback :PassthroughDevice, [:pointer, :pointer, PRInt32, PRInt32, PRBool], NSRESULT_TYPE
    callback :MountMedium, [:pointer, :pointer, PRInt32, PRInt32, :pointer, PRBool], NSRESULT_TYPE
    callback :GetMedium, [:pointer, :pointer, PRInt32, PRInt32, :pointer], NSRESULT_TYPE
    callback :GetMediumAttachmentsOfController, [:pointer, :pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :GetMediumAttachment, [:pointer, :pointer, PRInt32, PRInt32, :pointer], NSRESULT_TYPE
    callback :GetNetworkAdapter, [:pointer, PRInt32, :pointer], NSRESULT_TYPE
    callback :AddStorageController, [:pointer, :pointer, PRUint32, :pointer], NSRESULT_TYPE
    callback :GetStorageControllerByName, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :GetStorageControllerByInstance, [:pointer, PRUint32, :pointer], NSRESULT_TYPE
    callback :RemoveStorageController, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetSerialPort, [:pointer, PRUint32, :pointer], NSRESULT_TYPE
    callback :GetParallelPort, [:pointer, PRUint32, :pointer], NSRESULT_TYPE
    callback :GetExtraDataKeys, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :GetExtraData, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :SetExtraData, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :GetCpuProperty, [:pointer, PRUint32, :pointer], NSRESULT_TYPE
    callback :SetCpuProperty, [:pointer, PRUint32, PRBool], NSRESULT_TYPE
    callback :GetCpuIdLeaf, [:pointer, PRUint32, :pointer, :pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :SetCpuIdLeaf, [:pointer, PRUint32, PRUint32, PRUint32, PRUint32, PRUint32], NSRESULT_TYPE
    callback :RemoveCpuIdLeaf, [:pointer, PRUint32], NSRESULT_TYPE
    callback :RemoveAllCpuIdLeafs, [:pointer], NSRESULT_TYPE
    callback :GetHWVirtExProperty, [:pointer, PRUint32, :pointer], NSRESULT_TYPE
    callback :SetHWVirtExProperty, [:pointer, PRUint32, PRBool], NSRESULT_TYPE
    callback :SaveSettings, [:pointer], NSRESULT_TYPE
    callback :DiscardSettings, [:pointer], NSRESULT_TYPE
    callback :DeleteSettings, [:pointer], NSRESULT_TYPE
    callback :Export, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :GetSnapshot, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :FindSnapshot, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :SetCurrentSnapshot, [:pointer, :pointer], NSRESULT_TYPE
    callback :CreateSharedFolder, [:pointer, :pointer, :pointer, PRBool], NSRESULT_TYPE
    callback :RemoveSharedFolder, [:pointer, :pointer], NSRESULT_TYPE
    callback :CanShowConsoleWindow, [:pointer, :pointer], NSRESULT_TYPE
    callback :ShowConsoleWindow, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetGuestProperty, [:pointer, :pointer, :pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :GetGuestPropertyValue, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :GetGuestPropertyTimestamp, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :SetGuestProperty, [:pointer, :pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :SetGuestPropertyValue, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :EnumerateGuestProperties, [:pointer, :pointer, :pointer, :pointer, :pointer, :pointer, :pointer, :pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :QuerySavedThumbnailSize, [:pointer, :pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :ReadSavedThumbnailToArray, [:pointer, PRBool, :pointer, :pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :QuerySavedScreenshotPNGSize, [:pointer, :pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :ReadSavedScreenshotPNGToArray, [:pointer, :pointer, :pointer, :pointer, :pointer], NSRESULT_TYPE

    class IMachine_vtbl < ::FFI::Struct
      layout  :nsisupports, NSISupports_vtbl,
              :GetParent, :GetParent,
              :GetAccessible, :GetAccessible,
              :GetAccessError, :GetAccessError,
              :GetName, :GetName,
              :SetName, :SetName,
              :GetDescription, :GetDescription,
              :SetDescription, :SetDescription,
              :GetId, :GetId,
              :GetOSTypeId, :GetOSTypeId,
              :SetOSTypeId, :SetOSTypeId,
              :GetHardwareVersion, :GetHardwareVersion,
              :SetHardwareVersion, :SetHardwareVersion,
              :GetHardwareUUID, :GetHardwareUUID,
              :SetHardwareUUID, :SetHardwareUUID,
              :GetCPUCount, :GetCPUCount,
              :SetCPUCount, :SetCPUCount,
              :GetMemorySize, :GetMemorySize,
              :SetMemorySize, :SetMemorySize,
              :GetMemoryBalloonSize, :GetMemoryBalloonSize,
              :SetMemoryBalloonSize, :SetMemoryBalloonSize,
              :GetStatisticsUpdateInterval, :GetStatisticsUpdateInterval,
              :SetStatisticsUpdateInterval, :SetStatisticsUpdateInterval,
              :GetVRAMSize, :GetVRAMSize,
              :SetVRAMSize, :SetVRAMSize,
              :GetAccelerate3DEnabled, :GetAccelerate3DEnabled,
              :SetAccelerate3DEnabled, :SetAccelerate3DEnabled,
              :GetAccelerate2DVideoEnabled, :GetAccelerate2DVideoEnabled,
              :SetAccelerate2DVideoEnabled, :SetAccelerate2DVideoEnabled,
              :GetMonitorCount, :GetMonitorCount,
              :SetMonitorCount, :SetMonitorCount,
              :GetBIOSSettings, :GetBIOSSettings,
              :GetFirmwareType, :GetFirmwareType,
              :SetFirmwareType, :SetFirmwareType,
              :GetSnapshotFolder, :GetSnapshotFolder,
              :SetSnapshotFolder, :SetSnapshotFolder,
              :GetVRDPServer, :GetVRDPServer,
              :GetMediumAttachments, :GetMediumAttachments,
              :GetUSBController, :GetUSBController,
              :GetAudioAdapter, :GetAudioAdapter,
              :GetStorageControllers, :GetStorageControllers,
              :GetSettingsFilePath, :GetSettingsFilePath,
              :GetSettingsModified, :GetSettingsModified,
              :GetSessionState, :GetSessionState,
              :GetSessionType, :GetSessionType,
              :GetSessionPid, :GetSessionPid,
              :GetState, :GetState,
              :GetLastStateChange, :GetLastStateChange,
              :GetStateFilePath, :GetStateFilePath,
              :GetLogFolder, :GetLogFolder,
              :GetCurrentSnapshot, :GetCurrentSnapshot,
              :GetSnapshotCount, :GetSnapshotCount,
              :GetCurrentStateModified, :GetCurrentStateModified,
              :GetSharedFolders, :GetSharedFolders,
              :GetClipboardMode, :GetClipboardMode,
              :SetClipboardMode, :SetClipboardMode,
              :GetGuestPropertyNotificationPatterns, :GetGuestPropertyNotificationPatterns,
              :SetGuestPropertyNotificationPatterns, :SetGuestPropertyNotificationPatterns,
              :GetTeleporterEnabled, :GetTeleporterEnabled,
              :SetTeleporterEnabled, :SetTeleporterEnabled,
              :GetTeleporterPort, :GetTeleporterPort,
              :SetTeleporterPort, :SetTeleporterPort,
              :GetTeleporterAddress, :GetTeleporterAddress,
              :SetTeleporterAddress, :SetTeleporterAddress,
              :GetTeleporterPassword, :GetTeleporterPassword,
              :SetTeleporterPassword, :SetTeleporterPassword,
              :SetBootOrder, :SetBootOrder,
              :GetBootOrder, :GetBootOrder,
              :AttachDevice, :AttachDevice,
              :DetachDevice, :DetachDevice,
              :PassthroughDevice, :PassthroughDevice,
              :MountMedium, :MountMedium,
              :GetMedium, :GetMedium,
              :GetMediumAttachmentsOfController, :GetMediumAttachmentsOfController,
              :GetMediumAttachment, :GetMediumAttachment,
              :GetNetworkAdapter, :GetNetworkAdapter,
              :AddStorageController, :AddStorageController,
              :GetStorageControllerByName, :GetStorageControllerByName,
              :GetStorageControllerByInstance, :GetStorageControllerByInstance,
              :RemoveStorageController, :RemoveStorageController,
              :GetSerialPort, :GetSerialPort,
              :GetParallelPort, :GetParallelPort,
              :GetExtraDataKeys, :GetExtraDataKeys,
              :GetExtraData, :GetExtraData,
              :SetExtraData, :SetExtraData,
              :GetCpuProperty, :GetCpuProperty,
              :SetCpuProperty, :SetCpuProperty,
              :GetCpuIdLeaf, :GetCpuIdLeaf,
              :SetCpuIdLeaf, :SetCpuIdLeaf,
              :RemoveCpuIdLeaf, :RemoveCpuIdLeaf,
              :RemoveAllCpuIdLeafs, :RemoveAllCpuIdLeafs,
              :GetHWVirtExProperty, :GetHWVirtExProperty,
              :SetHWVirtExProperty, :SetHWVirtExProperty,
              :SaveSettings, :SaveSettings,
              :DiscardSettings, :DiscardSettings,
              :DeleteSettings, :DeleteSettings,
              :Export, :Export,
              :GetSnapshot, :GetSnapshot,
              :FindSnapshot, :FindSnapshot,
              :SetCurrentSnapshot, :SetCurrentSnapshot,
              :CreateSharedFolder, :CreateSharedFolder,
              :RemoveSharedFolder, :RemoveSharedFolder,
              :CanShowConsoleWindow, :CanShowConsoleWindow,
              :ShowConsoleWindow, :ShowConsoleWindow,
              :GetGuestProperty, :GetGuestProperty,
              :GetGuestPropertyValue, :GetGuestPropertyValue,
              :GetGuestPropertyTimestamp, :GetGuestPropertyTimestamp,
              :SetGuestProperty, :SetGuestProperty,
              :SetGuestPropertyValue, :SetGuestPropertyValue,
              :EnumerateGuestProperties, :EnumerateGuestProperties,
              :QuerySavedThumbnailSize, :QuerySavedThumbnailSize,
              :ReadSavedThumbnailToArray, :ReadSavedThumbnailToArray,
              :QuerySavedScreenshotPNGSize, :QuerySavedScreenshotPNGSize,
              :ReadSavedScreenshotPNGToArray, :ReadSavedScreenshotPNGToArray
    end

    class IMachine < ::FFI::Struct
      layout :vtbl, :pointer # IMachine_vtbl

      def vtbl
        @_vtbl ||= IMachine_vtbl.new(self[:vtbl])
      end
    end
  end
end