module VirtualBox
  module FFI
    INETWORKADAPTER_IID_STR = "65607a27-2b73-4d43-b4cc-0ba2c817fbde"

    # Callbacks for INetworkAdapter_vtbl
    callback :ina_GetAdapterType, [:pointer, :pointer], NSRESULT_TYPE
    callback :ina_SetAdapterType, [:pointer, PRUint32], NSRESULT_TYPE
    callback :ina_GetSlot, [:pointer, :pointer], NSRESULT_TYPE
    callback :ina_GetEnabled, [:pointer, :pointer], NSRESULT_TYPE
    callback :ina_SetEnabled, [:pointer, PRBool], NSRESULT_TYPE
    callback :ina_GetMACAddress, [:pointer, :pointer], NSRESULT_TYPE
    callback :ina_SetMACAddress, [:pointer, :pointer], NSRESULT_TYPE
    callback :ina_GetAttachmentType, [:pointer, :pointer], NSRESULT_TYPE
    callback :ina_GetHostInterface, [:pointer, :pointer], NSRESULT_TYPE
    callback :ina_SetHostInterface, [:pointer, :pointer], NSRESULT_TYPE
    callback :ina_GetInternalNetwork, [:pointer, :pointer], NSRESULT_TYPE
    callback :ina_SetInternalNetwork, [:pointer, :pointer], NSRESULT_TYPE
    callback :ina_GetNATNetwork, [:pointer, :pointer], NSRESULT_TYPE
    callback :ina_SetNATNetwork, [:pointer, :pointer], NSRESULT_TYPE
    callback :ina_GetCableConnected, [:pointer, :pointer], NSRESULT_TYPE
    callback :ina_SetCableConnected, [:pointer, PRBool], NSRESULT_TYPE
    callback :ina_GetLineSpeed, [:pointer, :pointer], NSRESULT_TYPE
    callback :ina_SetLineSpeed, [:pointer, PRUint32], NSRESULT_TYPE
    callback :ina_GetTraceEnabled, [:pointer, :pointer], NSRESULT_TYPE
    callback :ina_SetTraceEnabled, [:pointer, :pointer], NSRESULT_TYPE
    callback :ina_GetTraceFile, [:pointer, :pointer], NSRESULT_TYPE
    callback :ina_SetTraceFile, [:pointer, :pointer], NSRESULT_TYPE
    callback :ina_AttachToNAT, [:pointer], NSRESULT_TYPE
    callback :ina_AttachToBridgedInterface, [:pointer], NSRESULT_TYPE
    callback :ina_AttachToInternalNetwork, [:pointer], NSRESULT_TYPE
    callback :ina_AttachToHostOnlyInterface, [:pointer], NSRESULT_TYPE
    callback :ina_Detach, [:pointer], NSRESULT_TYPE

    class NetworkAdapterType < Enum
      map [:null, :Am79C970A, :Am79C973, :I82540EM, :I82543GC, :I82545EM, :Virtio]
    end

    class NetworkAttachmentType < Enum
      map [:null, :nat, :bridged, :internal, :host_only]
    end

    class INetworkAdapter < VTblParent
      parent_of :INetworkAdapter_vtbl
    end

    class INetworkAdapter_vtbl < VTbl
      define_layout do
        member :nsisupports, NSISupports_vtbl

        with_opts(:function_type_prefix => :ina_) do
          member :GetAdapterType, :getter, :NetworkAdapterType
          member :SetAdapterType, :function, [:NetworkAdapterType]
          member :GetSlot, :getter, PRUint32
          member :GetEnabled, :getter, PRBool
          member :SetEnabled, :function, [PRBool]
          member :GetMACAddress, :getter, :unicode_string
          member :SetMACAddress, :function, [:unicode_string]
          member :GetAttachmentType, :getter, :NetworkAttachmentType
          member :GetHostInterface, :getter, :unicode_string
          member :SetHostInterface, :function, [:unicode_string]
          member :GetInternalNetwork, :getter, :unicode_string
          member :SetInternalNetwork, :function, [:unicode_string]
          member :GetNATNetwork, :getter, :unicode_string
          member :SetNATNetwork, :function, [:unicode_string]
          member :GetCableConnected, :getter, PRBool
          member :SetCableConnected, :function, [PRBool]
          member :GetLineSpeed, :getter, PRUint32
          member :SetLineSpeed, :function, [PRUint32]
          member :GetTraceEnabled, :getter, PRBool
          member :SetTraceEnabled, :function, [PRBool]
          member :GetTraceFile, :getter, :unicode_string
          member :SetTraceFile, :function, [:unicode_string]
          member :AttachToNAT, :function, []
          member :AttachToBridgedInterface, :function, []
          member :AttachToInternalNetwork, :function, []
          member :AttachToHostOnlyInterface, :function, []
          member :Detach, :function, []
        end
      end
    end
  end
end