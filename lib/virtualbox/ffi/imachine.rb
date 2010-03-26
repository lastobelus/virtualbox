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

    class IMachine < VTblParent
      parent_of :IMachine_vtbl
    end

    class IMachine_vtbl < VTbl
      define_layout do
        member :nsisupports, NSISupports_vtbl
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
        member :GetClipboardMode, :getter, PRUint32
        member :SetClipboardMode, :function, [PRUint32]
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
        member :GetMediumAttachmentsOfController, :GetMediumAttachmentsOfController
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
        member :Export, :Export
        member :GetSnapshot, :GetSnapshot
        member :FindSnapshot, :FindSnapshot
        member :SetCurrentSnapshot, :SetCurrentSnapshot
        member :CreateSharedFolder, :CreateSharedFolder
        member :RemoveSharedFolder, :RemoveSharedFolder
        member :CanShowConsoleWindow, :CanShowConsoleWindow
        member :ShowConsoleWindow, :ShowConsoleWindow
        member :GetGuestProperty, :GetGuestProperty
        member :GetGuestPropertyValue, :GetGuestPropertyValue
        member :GetGuestPropertyTimestamp, :GetGuestPropertyTimestamp
        member :SetGuestProperty, :SetGuestProperty
        member :SetGuestPropertyValue, :SetGuestPropertyValue
        member :EnumerateGuestProperties, :EnumerateGuestProperties
        member :QuerySavedThumbnailSize, :QuerySavedThumbnailSize
        member :ReadSavedThumbnailToArray, :ReadSavedThumbnailToArray
        member :QuerySavedScreenshotPNGSize, :QuerySavedScreenshotPNGSize
        member :ReadSavedScreenshotPNGToArray, :ReadSavedScreenshotPNGToArray
      end
    end
  end
end