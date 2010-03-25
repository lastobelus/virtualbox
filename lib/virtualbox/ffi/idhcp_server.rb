module VirtualBox
  module FFI
    IDHCPSERVER_IID_STR = "6cfe387c-74fb-4ca7-bff6-973bec8af7a3"

    # Callbacks for IDHCPServer_vtbl
    callback :ids_GetEnabled, [:pointer, :pointer], NSRESULT_TYPE
    callback :ids_SetEnabled, [:pointer, PRBool], NSRESULT_TYPE
    callback :ids_GetIPAddress, [:pointer, :pointer], NSRESULT_TYPE
    callback :ids_GetNetworkMask, [:pointer, :pointer], NSRESULT_TYPE
    callback :ids_GetNetworkName, [:pointer, :pointer], NSRESULT_TYPE
    callback :ids_GetLowerIP, [:pointer, :pointer], NSRESULT_TYPE
    callback :ids_GetUpperIP, [:pointer, :pointer], NSRESULT_TYPE
    callback :ids_SetConfiguration, [:pointer, :pointer, :pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :ids_Start, [:pointer, :pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :ids_Stop, [:pointer], NSRESULT_TYPE

    class IDHCPServer < VTblParent
      parent_of :IDHCPServer_vtbl
    end

    class IDHCPServer_vtbl < VTbl
      define_layout do
        member :nsisupports, NSISupports_vtbl

        with_opts(:function_type_prefix => :ids_) do
          member :GetEnabled, :getter, PRBool
          member :SetEnabled, :function, [PRBool]
          member :GetIPAddress, :getter, :unicode_string
          member :GetNetworkMask, :getter, :unicode_string
          member :GetNetworkName, :getter, :unicode_string
          member :GetLowerIP, :getter, :unicode_string
          member :GetUpperIP, :getter, :unicode_string
          member :SetConfiguration, :function, [:unicode_string, :unicode_string, :unicode_string, :unicode_string]
          member :Start, :function, [:unicode_string, :unicode_string, :unicode_string]
          member :Stop, :function, []
        end
      end
    end
  end
end