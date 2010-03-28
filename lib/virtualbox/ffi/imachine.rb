module VirtualBox
  module FFI
    IMACHINE_IID_STR = "99404f50-dd10-40d3-889b-dd2f79f1e95e"

    # Callback types for IMachine_vtbl
    callback :im_GetParent, [:pointer, :pointer], NSRESULT_TYPE
    callback :im_GetAccessible, [:pointer, :pointer], NSRESULT_TYPE
    callback :im_GetAccessError, [:pointer, :pointer], NSRESULT_TYPE
    callback :im_GetName, [:pointer, :pointer], NSRESULT_TYPE
    callback :im_SetName, [:pointer, :pointer], NSRESULT_TYPE
    callback :im_GetDescription, [:pointer, :pointer], NSRESULT_TYPE
    callback :im_SetDescription, [:pointer, :pointer], NSRESULT_TYPE
    callback :im_GetId, [:pointer, :pointer], NSRESULT_TYPE
    callback :im_GetOSTypeId, [:pointer, :pointer], NSRESULT_TYPE
    callback :im_SetOSTypeId, [:pointer, :pointer], NSRESULT_TYPE
    callback :im_GetHardwareVersion, [:pointer, :pointer], NSRESULT_TYPE
    callback :im_SetHardwareVersion, [:pointer, :pointer], NSRESULT_TYPE
    callback :im_GetHardwareUUID, [:pointer, :pointer], NSRESULT_TYPE
    callback :im_SetHardwareUUID, [:pointer, :pointer], NSRESULT_TYPE
    callback :im_GetCPUCount, [:pointer, :pointer], NSRESULT_TYPE
    callback :im_SetCPUCount, [:pointer, PRUint32], NSRESULT_TYPE
    callback :im_GetMemorySize, [:pointer, :pointer], NSRESULT_TYPE
    callback :im_SetMemorySize, [:pointer, PRUint32], NSRESULT_TYPE
    callback :im_GetMemoryBalloonSize, [:pointer, :pointer], NSRESULT_TYPE
    callback :im_SetMemoryBalloonSize, [:pointer, PRUint32], NSRESULT_TYPE
    callback :im_GetStatisticsUpdateInterval, [:pointer, :pointer], NSRESULT_TYPE
    callback :im_SetStatisticsUpdateInterval, [:pointer, PRUint32], NSRESULT_TYPE
    callback :im_GetVRAMSize, [:pointer, :pointer], NSRESULT_TYPE
    callback :im_SetVRAMSize, [:pointer, PRUint32], NSRESULT_TYPE
    callback :im_GetAccelerate3DEnabled, [:pointer, :pointer], NSRESULT_TYPE
    callback :im_SetAccelerate3DEnabled, [:pointer, PRBool], NSRESULT_TYPE
    callback :im_GetAccelerate2DVideoEnabled, [:pointer, :pointer], NSRESULT_TYPE
    callback :im_SetAccelerate2DVideoEnabled, [:pointer, PRBool], NSRESULT_TYPE
    callback :im_GetMonitorCount, [:pointer, :pointer], NSRESULT_TYPE
    callback :im_SetMonitorCount, [:pointer, PRUint32], NSRESULT_TYPE
    callback :im_GetBIOSSettings, [:pointer, :pointer], NSRESULT_TYPE
    callback :im_GetFirmwareType, [:pointer, :pointer], NSRESULT_TYPE
    callback :im_SetFirmwareType, [:pointer, PRUint32], NSRESULT_TYPE
    callback :im_GetSnapshotFolder, [:pointer, :pointer], NSRESULT_TYPE
    callback :im_SetSnapshotFolder, [:pointer, :pointer], NSRESULT_TYPE
    callback :im_GetVRDPServer, [:pointer, :pointer], NSRESULT_TYPE
    callback :im_GetMediumAttachments, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :im_GetUSBController, [:pointer, :pointer], NSRESULT_TYPE
    callback :im_GetAudioAdapter, [:pointer, :pointer], NSRESULT_TYPE
    callback :im_GetStorageControllers, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :im_GetSettingsFilePath, [:pointer, :pointer], NSRESULT_TYPE
    callback :im_GetSettingsModified, [:pointer, :pointer], NSRESULT_TYPE
    callback :im_GetSessionState, [:pointer, :pointer], NSRESULT_TYPE
    callback :im_GetSessionType, [:pointer, :pointer], NSRESULT_TYPE
    callback :im_GetSessionPid, [:pointer, :pointer], NSRESULT_TYPE
    callback :im_GetState, [:pointer, :pointer], NSRESULT_TYPE
    callback :im_GetLastStateChange, [:pointer, :pointer], NSRESULT_TYPE
    callback :im_GetStateFilePath, [:pointer, :pointer], NSRESULT_TYPE
    callback :im_GetLogFolder, [:pointer, :pointer], NSRESULT_TYPE
    callback :im_GetCurrentSnapshot, [:pointer, :pointer], NSRESULT_TYPE
    callback :im_GetSnapshotCount, [:pointer, :pointer], NSRESULT_TYPE
    callback :im_GetCurrentStateModified, [:pointer, :pointer], NSRESULT_TYPE
    callback :im_GetSharedFolders, [:pointer, :pointer], NSRESULT_TYPE
    callback :im_GetClipboardMode, [:pointer, :pointer], NSRESULT_TYPE
    callback :im_SetClipboardMode, [:pointer, PRUint32], NSRESULT_TYPE
    callback :im_GetGuestPropertyNotificationPatterns, [:pointer, :pointer], NSRESULT_TYPE
    callback :im_SetGuestPropertyNotificationPatterns, [:pointer, :pointer], NSRESULT_TYPE
    callback :im_GetTeleporterEnabled, [:pointer, :pointer], NSRESULT_TYPE
    callback :im_SetTeleporterEnabled, [:pointer, PRBool], NSRESULT_TYPE
    callback :im_GetTeleporterPort, [:pointer, :pointer], NSRESULT_TYPE
    callback :im_SetTeleporterPort, [:pointer, PRUint32], NSRESULT_TYPE
    callback :im_GetTeleporterAddress, [:pointer, :pointer], NSRESULT_TYPE
    callback :im_SetTeleporterAddress, [:pointer, :pointer], NSRESULT_TYPE
    callback :im_GetTeleporterPassword, [:pointer, :pointer], NSRESULT_TYPE
    callback :im_SetTeleporterPassword, [:pointer, :pointer], NSRESULT_TYPE
    callback :im_SetBootOrder, [:pointer, PRUint32, PRUint32], NSRESULT_TYPE
    callback :im_GetBootOrder, [:pointer, PRUint32, :pointer], NSRESULT_TYPE
    callback :im_AttachDevice, [:pointer, :pointer, PRInt32, PRInt32, PRUint32, :pointer], NSRESULT_TYPE
    callback :im_DetachDevice, [:pointer, :pointer, PRInt32, PRInt32], NSRESULT_TYPE
    callback :im_PassthroughDevice, [:pointer, :pointer, PRInt32, PRInt32, PRBool], NSRESULT_TYPE
    callback :im_MountMedium, [:pointer, :pointer, PRInt32, PRInt32, :pointer, PRBool], NSRESULT_TYPE
    callback :im_GetMedium, [:pointer, :pointer, PRInt32, PRInt32, :pointer], NSRESULT_TYPE
    callback :im_GetMediumAttachmentsOfController, [:pointer, :pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :im_GetMediumAttachment, [:pointer, :pointer, PRInt32, PRInt32, :pointer], NSRESULT_TYPE
    callback :im_GetNetworkAdapter, [:pointer, PRInt32, :pointer], NSRESULT_TYPE
    callback :im_AddStorageController, [:pointer, :pointer, PRUint32, :pointer], NSRESULT_TYPE
    callback :im_GetStorageControllerByName, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :im_GetStorageControllerByInstance, [:pointer, PRUint32, :pointer], NSRESULT_TYPE
    callback :im_RemoveStorageController, [:pointer, :pointer], NSRESULT_TYPE
    callback :im_GetSerialPort, [:pointer, PRUint32, :pointer], NSRESULT_TYPE
    callback :im_GetParallelPort, [:pointer, PRUint32, :pointer], NSRESULT_TYPE
    callback :im_GetExtraDataKeys, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :im_GetExtraData, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :im_SetExtraData, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :im_GetCpuProperty, [:pointer, PRUint32, :pointer], NSRESULT_TYPE
    callback :im_SetCpuProperty, [:pointer, PRUint32, PRBool], NSRESULT_TYPE
    callback :im_GetCpuIdLeaf, [:pointer, PRUint32, :pointer, :pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :im_SetCpuIdLeaf, [:pointer, PRUint32, PRUint32, PRUint32, PRUint32, PRUint32], NSRESULT_TYPE
    callback :im_RemoveCpuIdLeaf, [:pointer, PRUint32], NSRESULT_TYPE
    callback :im_RemoveAllCpuIdLeafs, [:pointer], NSRESULT_TYPE
    callback :im_GetHWVirtExProperty, [:pointer, PRUint32, :pointer], NSRESULT_TYPE
    callback :im_SetHWVirtExProperty, [:pointer, PRUint32, PRBool], NSRESULT_TYPE
    callback :im_SaveSettings, [:pointer], NSRESULT_TYPE
    callback :im_DiscardSettings, [:pointer], NSRESULT_TYPE
    callback :im_DeleteSettings, [:pointer], NSRESULT_TYPE
    callback :im_Export, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :im_GetSnapshot, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :im_FindSnapshot, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :im_SetCurrentSnapshot, [:pointer, :pointer], NSRESULT_TYPE
    callback :im_CreateSharedFolder, [:pointer, :pointer, :pointer, PRBool], NSRESULT_TYPE
    callback :im_RemoveSharedFolder, [:pointer, :pointer], NSRESULT_TYPE
    callback :im_CanShowConsoleWindow, [:pointer, :pointer], NSRESULT_TYPE
    callback :im_ShowConsoleWindow, [:pointer, :pointer], NSRESULT_TYPE
    callback :im_GetGuestProperty, [:pointer, :pointer, :pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :im_GetGuestPropertyValue, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :im_GetGuestPropertyTimestamp, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :im_SetGuestProperty, [:pointer, :pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :im_SetGuestPropertyValue, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :im_EnumerateGuestProperties, [:pointer, :pointer, :pointer, :pointer, :pointer, :pointer, :pointer, :pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :im_QuerySavedThumbnailSize, [:pointer, :pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :im_ReadSavedThumbnailToArray, [:pointer, PRBool, :pointer, :pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :im_QuerySavedScreenshotPNGSize, [:pointer, :pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :im_ReadSavedScreenshotPNGToArray, [:pointer, :pointer, :pointer, :pointer, :pointer], NSRESULT_TYPE

    class ClipboardMode < Enum
      map [:disabled, :host_to_guest, :guest_to_host, :bidirectional]
    end

    class IMachine < VTblParent
      parent_of :IMachine_vtbl
    end

    class IMachine_vtbl < VTbl
      define_layout do
        member :nsisupports, NSISupports_vtbl

        with_opts(:function_type_prefix => :im_) do
          member :GetParent, :getter, :IVirtualBox
          member :GetAccessible, :getter, PRBool
          member :GetAccessError, :getter, :IVirtualBoxErrorInfo
          member :GetName, :getter, :unicode_string
          member :SetName, :function, [:unicode_string]
          member :GetDescription, :getter, :unicode_string
          member :SetDescription, :function, [:unicode_string]
          member :GetId, :getter, :unicode_string
          member :GetOSTypeId, :getter, :unicode_string
          member :SetOSTypeId, :function, [:unicode_string]
          member :GetHardwareVersion, :getter, :unicode_string
          member :SetHardwareVersion, :function, [:unicode_string]
          member :GetHardwareUUID, :getter, :unicode_string
          member :SetHardwareUUID, :function, [:unicode_string]
          member :GetCPUCount, :getter, PRUint32
          member :SetCPUCount, :function, [PRUint32]
          member :GetMemorySize, :getter, PRUint32
          member :SetMemorySize, :function, [PRUint32]
          member :GetMemoryBalloonSize, :getter, PRUint32
          member :SetMemoryBalloonSize, :function, [PRUint32]
          member :GetStatisticsUpdateInterval, :getter, PRUint32
          member :SetStatisticsUpdateInterval, :function, [PRUint32]
          member :GetVRAMSize, :getter, PRUint32
          member :SetVRAMSize, :function, [PRUint32]
          member :GetAccelerate3DEnabled, :getter, PRBool
          member :SetAccelerate3DEnabled, :function, [PRBool]
          member :GetAccelerate2DVideoEnabled, :getter, PRBool
          member :SetAccelerate2DVideoEnabled, :function, [PRBool]
          member :GetMonitorCount, :getter, PRUint32
          member :SetMonitorCount, :function, [PRUint32]
          member :GetBIOSSettings, :getter, :IBIOSSettings
          member :GetFirmwareType, :getter, PRUint32
          member :SetFirmwareType, :function, [PRUint32]
          member :GetSnapshotFolder, :getter, :unicode_string
          member :SetSnapshotFolder, :function, [:unicode_string]
          member :GetVRDPServer, :getter, :IVRDPServer
          member :GetMediumAttachments, :array_getter, :IMediumAttachment
          member :GetUSBController, :getter, :IUSBController
          member :GetAudioAdapter, :getter, :IAudioAdapter
          member :GetStorageControllers, :array_getter, :IStorageController
          member :GetSettingsFilePath, :getter, :unicode_string
          member :GetSettingsModified, :getter, PRBool
          member :GetSessionState, :getter, PRUint32
          member :GetSessionType, :getter, :unicode_string
          member :GetSessionPid, :getter, PRUint32
          member :GetState, :getter, PRUint32
          member :GetLastStateChange, :getter, PRInt64
          member :GetStateFilePath, :getter, :unicode_string
          member :GetLogFolder, :getter, :unicode_string
          member :GetCurrentSnapshot, :getter, :ISnapshot
          member :GetSnapshotCount, :getter, PRUint32
          member :GetCurrentStateModified, :getter, PRBool
          member :GetSharedFolders, :array_getter, :ISharedFolder
          member :GetClipboardMode, :getter, :ClipboardMode
          member :SetClipboardMode, :function, [:ClipboardMode]
          member :GetGuestPropertyNotificationPatterns, :getter, :unicode_string
          member :SetGuestPropertyNotificationPatterns, :function, [:unicode_string]
          member :GetTeleporterEnabled, :getter, PRBool
          member :SetTeleporterEnabled, :function, [PRBool]
          member :GetTeleporterPort, :getter, PRUint32
          member :SetTeleporterPort, :function, [PRUint32]
          member :GetTeleporterAddress, :getter, :unicode_string
          member :SetTeleporterAddress, :function, [:unicode_string]
          member :GetTeleporterPassword, :getter, :unicode_string
          member :SetTeleporterPassword, :function, [:unicode_string]
          member :SetBootOrder, :function, [PRUint32, PRUint32]
          member :GetBootOrder, :function, [PRUint32, [:out, PRUint32]]
          member :AttachDevice, :function, [:unicode_string, PRInt32, PRInt32, PRUint32, :unicode_string]
          member :DetachDevice, :function, [:unicode_string, PRInt32, PRInt32]
          member :PassthroughDevice, :function, [:unicode_string, PRInt32, PRInt32, PRBool]
          member :MountMedium, :function, [:unicode_string, PRInt32, PRInt32, :unicode_string, PRBool]
          member :GetMedium, :function, [:unicode_string, PRInt32, PRInt32, [:out, :IMedium]]
          member :GetMediumAttachmentsOfController, :im_GetMediumAttachmentsOfController
          member :GetMediumAttachment, :function, [:unicode_string, PRInt32, PRInt32, [:out, :IMediumAttachment]]
          member :GetNetworkAdapter, :function, [PRUint32, [:out, :INetworkAdapter]]
          member :AddStorageController, :function, [:unicode_string, PRUint32, [:out, :IStorageController]]
          member :GetStorageControllerByName, :function, [:unicode_string, [:out, :IStorageController]]
          member :GetStorageControllerByInstance, :function, [PRUint32, [:out, :IStorageController]]
          member :RemoveStorageController, :function, [:unicode_string]
          member :GetSerialPort, :function, [PRUint32, [:out, :ISerialPort]]
          member :GetParallelPort, :function, [PRUint32, [:out, :IParallelPort]]
          member :GetExtraDataKeys, :array_getter, :unicode_string
          member :GetExtraData, :function, [:unicode_string, [:out, :unicode_string]]
          member :SetExtraData, :function, [:unicode_string, :unicode_string]
          member :GetCpuProperty, :function, [PRUint32, [:out, PRBool]]
          member :SetCpuProperty, :function, [PRUint32, PRBool]
          member :GetCpuIdLeaf, :function, [PRUint32, [:out, PRUint32], [:out, PRUint32], [:out, PRUint32], [:out, PRUint32]]
          member :SetCpuIdLeaf, :function, [PRUint32, PRUint32, PRUint32, PRUint32, PRUint32]
          member :RemoveCpuIdLeaf, :function, [PRUint32]
          member :RemoveAllCpuIdLeafs, :function, []
          member :GetHWVirtExProperty, :function, [PRUint32, [:out, PRBool]]
          member :SetHWVirtExProperty, :function, [PRUint32, [:out, PRBool]]
          member :SaveSettings, :function, []
          member :DiscardSettings, :function, []
          member :DeleteSettings, :function, []
          member :Export, :function, [:IAppliance, [:out, :IVirtualSystemDescription]]
          member :GetSnapshot, :function, [:unicode_string, [:out, :ISnapshot]]
          member :FindSnapshot, :function, [:unicode_string, [:out, :ISnapshot]]
          member :SetCurrentSnapshot, :function, [:unicode_string]
          member :CreateSharedFolder, :function, [:unicode_string, :unicode_string, PRBool]
          member :RemoveSharedFolder, :function, [:unicode_string]
          member :CanShowConsoleWindow, :function, [[:out, PRBool]]
          member :ShowConsoleWindow, :function, [[:out, PRUint64]]
          member :GetGuestProperty, :function, [:unicode_string, [:out, :unicode_string], [:out, PRUint64], [:out, :unicode_string]]
          member :GetGuestPropertyValue, :function, [:unicode_string, [:out, :unicode_string]]
          member :GetGuestPropertyTimestamp, :function, [:unicode_string, [:out, PRUint64]]
          member :SetGuestProperty, :function, [:unicode_string, :unicode_string, :unicode_string]
          member :SetGuestPropertyValue, :function, [:unicode_string, :unicode_string]
          member :EnumerateGuestProperties, :im_EnumerateGuestProperties
          member :QuerySavedThumbnailSize, :function, [[:out, PRUint32], [:out, PRUint32], [:out, PRUint32]]
          member :ReadSavedThumbnailToArray, :im_ReadSavedThumbnailToArray
          member :QuerySavedScreenshotPNGSize, :function, [[:out, PRUint32], [:out, PRUint32], [:out, PRUint32]]
          member :ReadSavedScreenshotPNGToArray, :im_ReadSavedScreenshotPNGToArray
        end
      end
    end
  end
end