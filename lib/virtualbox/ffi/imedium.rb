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

    class MediumState < Enum
      map [:not_created, :created, :locked_read, :locked_write, :inaccessible, :creating, :deleting]
    end

    class MediumType < Enum
      map [:normal, :immutable, :write_through]
    end

    class MediumVariant < Enum
      map [:standard, :vmdk_split_2g, :vmdk_stream_optimized, :vmdk_esx, :fixed, :diff]
    end

    class IMedium < VTblParent
      parent_of :IMedium_vtbl
    end

    class IMedium_vtbl < VTbl
      define_layout do
        member :nsisupports, NSISupports_vtbl
        member :GetId, :getter, :unicode_string
        member :GetDescription, :getter, :unicode_string
        member :SetDescription, :SetDescription
        member :GetState, :getter, PRUint32
        member :GetLocation, :getter, :unicode_string
        member :SetLocation, :function, [:unicode_string]
        member :GetName, :getter, :unicode_string
        member :GetDeviceType, :getter, PRUint32
        member :GetHostDrive, :getter, PRBool
        member :GetSize, :getter, PRUint64
        member :GetFormat, :getter, :unicode_string
        member :GetType, :getter, PRUint32
        member :SetType, :function, [PRUint32]
        member :GetParent, :getter, :IMedium
        member :GetChildren, :array_getter, :IMedium
        member :GetBase, :getter, :IMedium
        member :GetReadOnly, :getter, PRBool
        member :GetLogicalSize, :getter, PRUint64
        member :GetAutoReset, :getter, PRBool
        member :SetAutoReset, :function, [PRBool]
        member :GetLastAccessError, :getter, :unicode_string
        member :GetMachineIds, :array_getter, :unicode_string
        member :RefreshState, :getter, :MediumState
        member :GetSnapshotIds, :GetSnapshotIds
        member :LockRead, :LockRead
        member :UnlockRead, :UnlockRead
        member :LockWrite, :LockWrite
        member :UnlockWrite, :UnlockWrite
        member :Close, :function, []
        member :GetProperty, :function, [:unicode_string, [:out, :unicode_string]]
        member :SetProperty, :function, [:unicode_string, :unicode_string]
        member :GetProperties, :GetProperties
        member :SetProperties, :SetProperties
        member :CreateBaseStorage, :CreateBaseStorage
        member :DeleteStorage, :function, [[:out, :IProgress]]
        member :CreateDiffStorage, :CreateDiffStorage
        member :MergeTo, :function, [:unicode_string, [:out, :IProgress]]
        member :CloneTo, :CloneTo
        member :Compact, :function, [[:out, :IProgress]]
        member :Resize, :function, [PRUint64, [:out, :IProgress]]
        member :Reset, :function, [[:out, :IProgress]]
      end
    end
  end
end