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
        member :GetMediumAttachments, :GetMediumAttachments
        member :GetUSBController, :GetUSBController
        member :GetAudioAdapter, :GetAudioAdapter
        member :GetStorageControllers, :GetStorageControllers
        member :GetSettingsFilePath, :GetSettingsFilePath
        member :GetSettingsModified, :GetSettingsModified
        member :GetSessionState, :GetSessionState
        member :GetSessionType, :GetSessionType
        member :GetSessionPid, :GetSessionPid
        member :GetState, :GetState
        member :GetLastStateChange, :GetLastStateChange
        member :GetStateFilePath, :GetStateFilePath
        member :GetLogFolder, :GetLogFolder
        member :GetCurrentSnapshot, :GetCurrentSnapshot
        member :GetSnapshotCount, :GetSnapshotCount
        member :GetCurrentStateModified, :GetCurrentStateModified
        member :GetSharedFolders, :GetSharedFolders
        member :GetClipboardMode, :GetClipboardMode
        member :SetClipboardMode, :SetClipboardMode
        member :GetGuestPropertyNotificationPatterns, :GetGuestPropertyNotificationPatterns
        member :SetGuestPropertyNotificationPatterns, :SetGuestPropertyNotificationPatterns
        member :GetTeleporterEnabled, :GetTeleporterEnabled
        member :SetTeleporterEnabled, :SetTeleporterEnabled
        member :GetTeleporterPort, :GetTeleporterPort
        member :SetTeleporterPort, :SetTeleporterPort
        member :GetTeleporterAddress, :GetTeleporterAddress
        member :SetTeleporterAddress, :SetTeleporterAddress
        member :GetTeleporterPassword, :GetTeleporterPassword
        member :SetTeleporterPassword, :SetTeleporterPassword
        member :SetBootOrder, :SetBootOrder

        member :GetBootOrder, :function, [PRUint32, [:out, PRUint32]]
        #member :GetBootOrder, :GetBootOrder

        member :AttachDevice, :AttachDevice
        member :DetachDevice, :DetachDevice
        member :PassthroughDevice, :PassthroughDevice
        member :MountMedium, :MountMedium
        member :GetMedium, :GetMedium
        member :GetMediumAttachmentsOfController, :GetMediumAttachmentsOfController
        member :GetMediumAttachment, :GetMediumAttachment
        member :GetNetworkAdapter, :GetNetworkAdapter
        member :AddStorageController, :AddStorageController
        member :GetStorageControllerByName, :GetStorageControllerByName
        member :GetStorageControllerByInstance, :GetStorageControllerByInstance
        member :RemoveStorageController, :RemoveStorageController
        member :GetSerialPort, :GetSerialPort
        member :GetParallelPort, :GetParallelPort
        member :GetExtraDataKeys, :GetExtraDataKeys
        member :GetExtraData, :GetExtraData
        member :SetExtraData, :SetExtraData
        member :GetCpuProperty, :GetCpuProperty
        member :SetCpuProperty, :SetCpuProperty
        member :GetCpuIdLeaf, :GetCpuIdLeaf
        member :SetCpuIdLeaf, :SetCpuIdLeaf
        member :RemoveCpuIdLeaf, :RemoveCpuIdLeaf
        member :RemoveAllCpuIdLeafs, :RemoveAllCpuIdLeafs
        member :GetHWVirtExProperty, :GetHWVirtExProperty
        member :SetHWVirtExProperty, :SetHWVirtExProperty
        member :SaveSettings, :SaveSettings
        member :DiscardSettings, :DiscardSettings
        member :DeleteSettings, :DeleteSettings
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