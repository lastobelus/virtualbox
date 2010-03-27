module VirtualBox
  module FFI
    IMEDIUM_IID_STR = "aa8167ba-df72-4738-b740-9b84377ba9f1"

    # Callbacks for IMedium_vtbl
    callback :imed_GetId, [:pointer, :pointer], NSRESULT_TYPE
    callback :imed_GetDescription, [:pointer, :pointer], NSRESULT_TYPE
    callback :imed_SetDescription, [:pointer, :pointer], NSRESULT_TYPE
    callback :imed_GetState, [:pointer, :pointer], NSRESULT_TYPE
    callback :imed_GetLocation, [:pointer, :pointer], NSRESULT_TYPE
    callback :imed_SetLocation, [:pointer, :pointer], NSRESULT_TYPE
    callback :imed_GetName, [:pointer, :pointer], NSRESULT_TYPE
    callback :imed_GetDeviceType, [:pointer, :pointer], NSRESULT_TYPE
    callback :imed_GetHostDrive, [:pointer, :pointer], NSRESULT_TYPE
    callback :imed_GetSize, [:pointer, :pointer], NSRESULT_TYPE
    callback :imed_GetFormat, [:pointer, :pointer], NSRESULT_TYPE
    callback :imed_GetType, [:pointer, :pointer], NSRESULT_TYPE
    callback :imed_SetType, [:pointer, :pointer], NSRESULT_TYPE
    callback :imed_GetParent, [:pointer, :pointer], NSRESULT_TYPE
    callback :imed_GetChildren, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :imed_GetBase, [:pointer, :pointer], NSRESULT_TYPE
    callback :imed_GetReadOnly, [:pointer, :pointer], NSRESULT_TYPE
    callback :imed_GetLogicalSize, [:pointer, :pointer], NSRESULT_TYPE
    callback :imed_GetAutoReset, [:pointer, :pointer], NSRESULT_TYPE
    callback :imed_SetAutoReset, [:pointer, :pointer], NSRESULT_TYPE
    callback :imed_GetLastAccessError, [:pointer, :pointer], NSRESULT_TYPE
    callback :imed_GetMachineIds, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :imed_RefreshState, [:pointer, :pointer], NSRESULT_TYPE
    callback :imed_GetSnapshotIds, [:pointer, :pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :imed_LockRead, [:pointer, :pointer], NSRESULT_TYPE
    callback :imed_UnlockRead, [:pointer, :pointer], NSRESULT_TYPE
    callback :imed_LockWrite, [:pointer, :pointer], NSRESULT_TYPE
    callback :imed_UnlockWrite, [:pointer, :pointer], NSRESULT_TYPE
    callback :imed_Close, [:pointer], NSRESULT_TYPE
    callback :imed_GetProperty, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :imed_SetProperty, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :imed_GetProperties, [:pointer, :pointer, :pointer, :pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :imed_SetProperties, [:pointer, PRUint32, :pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :imed_CreateBaseStorage, [:pointer, PRUint64, PRUint32, :pointer], NSRESULT_TYPE
    callback :imed_DeleteStorage, [:pointer, :pointer], NSRESULT_TYPE
    callback :imed_CreateDiffStorage, [:pointer, :pointer, PRUint32, :pointer], NSRESULT_TYPE
    callback :imed_MergeTo, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :imed_CloneTo, [:pointer, :pointer, PRUint32, :pointer, :pointer], NSRESULT_TYPE
    callback :imed_Compact, [:pointer, :pointer], NSRESULT_TYPE
    callback :imed_Resize, [:pointer, PRUint64, :pointer], NSRESULT_TYPE
    callback :imed_Reset, [:pointer, :pointer], NSRESULT_TYPE

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

        with_opts(:function_type_prefix => :imed_) do
          member :GetId, :getter, :unicode_string
          member :GetDescription, :getter, :unicode_string
          member :SetDescription, :function, [:unicode_string]
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
          member :GetSnapshotIds, :imed_GetSnapshotIds
          member :LockRead, :getter, :MediumState
          member :UnlockRead, :getter, :MediumState
          member :LockWrite, :getter, :MediumState
          member :UnlockWrite, :getter, :MediumState
          member :Close, :function, []
          member :GetProperty, :function, [:unicode_string, [:out, :unicode_string]]
          member :SetProperty, :function, [:unicode_string, :unicode_string]
          member :GetProperties, :imed_GetProperties
          member :SetProperties, :imed_SetProperties
          member :CreateBaseStorage, :function, [PRUint64, :MediumVariant, [:out, :IProgress]]
          member :DeleteStorage, :function, [[:out, :IProgress]]
          member :CreateDiffStorage, :function, [:IMedium, :MediumVariant, [:out, :IProgress]]
          member :MergeTo, :function, [:unicode_string, [:out, :IProgress]]
          member :CloneTo, :function, [:IMedium, :MediumVariant, :IMedium, [:out, :IProgress]]
          member :Compact, :function, [[:out, :IProgress]]
          member :Resize, :function, [PRUint64, [:out, :IProgress]]
          member :Reset, :function, [[:out, :IProgress]]
        end
      end
    end
  end
end