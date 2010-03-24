module VirtualBox
  module FFI
    IMEDIUM_IID_STR = "aa8167ba-df72-4738-b740-9b84377ba9f1"

    # Callbacks for IMedium_vtbl
    callback :GetId, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetDescription, [:pointer, :pointer], NSRESULT_TYPE
    callback :SetDescription, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetState, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetLocation, [:pointer, :pointer], NSRESULT_TYPE
    callback :SetLocation, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetName, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetDeviceType, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetHostDrive, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetSize, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetFormat, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetType, [:pointer, :pointer], NSRESULT_TYPE
    callback :SetType, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetParent, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetChildren, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :GetBase, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetReadOnly, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetLogicalSize, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetAutoReset, [:pointer, :pointer], NSRESULT_TYPE
    callback :SetAutoReset, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetLastAccessError, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetMachineIds, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :RefreshState, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetSnapshotIds, [:pointer, :pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :LockRead, [:pointer, :pointer], NSRESULT_TYPE
    callback :UnlockRead, [:pointer, :pointer], NSRESULT_TYPE
    callback :LockWrite, [:pointer, :pointer], NSRESULT_TYPE
    callback :UnlockWrite, [:pointer, :pointer], NSRESULT_TYPE
    callback :Close, [:pointer], NSRESULT_TYPE
    callback :GetProperty, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :SetProperty, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :GetProperties, [:pointer, :pointer, :pointer, :pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :SetProperties, [:pointer, PRUint32, :pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :CreateBaseStorage, [:pointer, PRUint64, PRUint32, :pointer], NSRESULT_TYPE
    callback :DeleteStorage, [:pointer, :pointer], NSRESULT_TYPE
    callback :CreateDiffStorage, [:pointer, :pointer, PRUint32, :pointer], NSRESULT_TYPE
    callback :MergeTo, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :CloneTo, [:pointer, :pointer, PRUint32, :pointer, :pointer], NSRESULT_TYPE
    callback :Compact, [:pointer, :pointer], NSRESULT_TYPE
    callback :Resize, [:pointer, PRUint64, :pointer], NSRESULT_TYPE
    callback :Reset, [:pointer, :pointer], NSRESULT_TYPE

    class IMedium < VTblParent
      parent_of :IMedium_vtbl
    end

    class IMedium_vtbl < VTbl
      define_layout do
        member :nsisupports, NSISupports_vtbl
        member :GetId, :GetId
        member :GetDescription, :GetDescription
        member :SetDescription, :SetDescription
        member :GetState, :GetState
        member :GetLocation, :GetLocation
        member :SetLocation, :SetLocation
        member :GetName, :GetName
        member :GetDeviceType, :GetDeviceType
        member :GetHostDrive, :GetHostDrive
        member :GetSize, :GetSize
        member :GetFormat, :GetFormat
        member :GetType, :GetType
        member :SetType, :SetType
        member :GetParent, :GetParent
        member :GetChildren, :GetChildren
        member :GetBase, :GetBase
        member :GetReadOnly, :GetReadOnly
        member :GetLogicalSize, :GetLogicalSize
        member :GetAutoReset, :GetAutoReset
        member :SetAutoReset, :SetAutoReset
        member :GetLastAccessError, :GetLastAccessError
        member :GetMachineIds, :GetMachineIds
        member :RefreshState, :RefreshState
        member :GetSnapshotIds, :GetSnapshotIds
        member :LockRead, :LockRead
        member :UnlockRead, :UnlockRead
        member :LockWrite, :LockWrite
        member :UnlockWrite, :UnlockWrite
        member :Close, :Close
        member :GetProperty, :GetProperty
        member :SetProperty, :SetProperty
        member :GetProperties, :GetProperties
        member :SetProperties, :SetProperties
        member :CreateBaseStorage, :CreateBaseStorage
        member :DeleteStorage, :DeleteStorage
        member :CreateDiffStorage, :CreateDiffStorage
        member :MergeTo, :MergeTo
        member :CloneTo, :CloneTo
        member :Compact, :Compact
        member :Resize, :Resize
        member :Reset, :Reset
      end
    end
  end
end