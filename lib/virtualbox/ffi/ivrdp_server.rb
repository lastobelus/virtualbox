module VirtualBox
  module FFI
    IVRDPSERVER_IID_STR = "72e671bc-1712-4052-ad6b-e45e76d9d3e4"

    # Callbacks for IVRDPServer_vtbl
    callback :ivrdps_GetEnabled, [:pointer, :pointer], NSRESULT_TYPE
    callback :ivrdps_SetEnabled, [:pointer, PRBool], NSRESULT_TYPE
    callback :ivrdps_GetPorts, [:pointer, :pointer], NSRESULT_TYPE
    callback :ivrdps_SetPorts, [:pointer, :pointer], NSRESULT_TYPE
    callback :ivrdps_GetNetAddress, [:pointer, :pointer], NSRESULT_TYPE
    callback :ivrdps_SetNetAddress, [:pointer, :pointer], NSRESULT_TYPE
    callback :ivrdps_GetAuthType, [:pointer, :pointer], NSRESULT_TYPE
    callback :ivrdps_SetAuthType, [:pointer, PRUint32], NSRESULT_TYPE
    callback :ivrdps_GetAuthTimeout, [:pointer, :pointer], NSRESULT_TYPE
    callback :ivrdps_SetAuthTimeout, [:pointer, PRUint32], NSRESULT_TYPE
    callback :ivrdps_GetAllowMultiConnection, [:pointer, :pointer], NSRESULT_TYPE
    callback :ivrdps_SetAllowMultiConnection, [:pointer, PRBool], NSRESULT_TYPE
    callback :ivrdps_GetReuseSingleConnection, [:pointer, :pointer], NSRESULT_TYPE
    callback :ivrdps_SetReuseSingleConnection, [:pointer, PRBool], NSRESULT_TYPE

    class IVRDPServer < VTblParent
      parent_of :IVRDPServer_vtbl
    end

    class IVRDPServer_vtbl < VTbl
      define_layout do
        member :nsisupports, NSISupports_vtbl

        with_opts(:function_type_prefix => :ivrdps_) do
          member :GetEnabled, :getter, PRBool
          member :SetEnabled, :function, [PRBool]
          member :GetPorts, :getter, :unicode_string
          member :SetPorts, :function, [:unicode_string]
          member :GetNetAddress, :getter, :unicode_string
          member :SetNetAddress, :function, [:unicode_string]
          member :GetAuthType, :getter, PRUint32
          member :SetAuthType, :function, [PRUint32]
          member :GetAuthTimeout, :getter, PRUint32
          member :SetAuthTimeout, :function, [PRUint32]
          member :GetAllowMultiConnection, :getter, PRBool
          member :SetAllowMultiConnection, :function, [PRBool]
          member :GetReuseSingleConnection, :getter, PRBool
          member :SetReuseSingleConnection, :function, [PRBool]
        end
      end
    end
  end
end