module VirtualBox
  module FFI
    IHOSTNETWORKINTERFACE_IID_STR = "ce6fae58-7642-4102-b5db-c9005c2320a8"

    # Callbacks for IHostNetworkInterface_vtbl
    callback :ihni_GetName, [:pointer, :pointer], NSRESULT_TYPE
    callback :ihni_GetId, [:pointer, :pointer], NSRESULT_TYPE
    callback :ihni_GetNetworkName, [:pointer, :pointer], NSRESULT_TYPE
    callback :ihni_GetDhcpEnabled, [:pointer, :pointer], NSRESULT_TYPE
    callback :ihni_GetIPAddress, [:pointer, :pointer], NSRESULT_TYPE
    callback :ihni_GetNetworkMask, [:pointer, :pointer], NSRESULT_TYPE
    callback :ihni_GetIPV6Supported, [:pointer, :pointer], NSRESULT_TYPE
    callback :ihni_GetIPV6Address, [:pointer, :pointer], NSRESULT_TYPE
    callback :ihni_GetIPV6NetworkMaskPrefixLength, [:pointer, :pointer], NSRESULT_TYPE
    callback :ihni_GetHardwareAddress, [:pointer, :pointer], NSRESULT_TYPE
    callback :ihni_GetMediumType, [:pointer, :pointer], NSRESULT_TYPE
    callback :ihni_GetStatus, [:pointer, :pointer], NSRESULT_TYPE
    callback :ihni_GetInterfaceType, [:pointer, :pointer], NSRESULT_TYPE
    callback :ihni_EnableStaticIpConfig, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :ihni_EnableStaticIpConfigV6, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :ihni_EnableDynamicIpConfig, [:pointer], NSRESULT_TYPE
    callback :ihni_DhcpRediscover, [:pointer], NSRESULT_TYPE

    class IHostNetworkInterface < VTblParent
      parent_of :IHostNetworkInterface_vtbl
    end

    class IHostNetworkInterface_vtbl < VTbl
      define_layout do
        member :nsisupports, NSISupports_vtbl

        with_opts(:function_type_prefix => :ihni_) do
          member :GetName, :getter, :unicode_string
          member :GetId, :getter, :unicode_string
          member :GetNetworkName, :getter, :unicode_string
          member :GetDhcpEnabled, :getter, PRBool
          member :GetIPAddress, :getter, :unicode_string
          member :GetNetworkMask, :getter, :unicode_string
          member :GetIPV6Supported, :getter, PRBool
          member :GetIPV6Address, :getter, :unicode_string
          member :GetIPV6NetworkMaskPrefixLength, :getter, PRUint32
          member :GetHardwareAddress, :getter, :unicode_string
          member :GetMediumType, :getter, PRUint32
          member :GetStatus, :getter, PRUint32
          member :GetInterfaceType, :getter, PRUint32
          member :EnableStaticIpConfig, :function, [:unicode_string, :unicode_string]
          member :EnableStaticIpConfigV6, :function, [:unicode_string, PRUint32]
          member :EnableDynamicIpConfig, :function, []
          member :DhcpRediscover, :function, []
        end
      end
    end
  end
end