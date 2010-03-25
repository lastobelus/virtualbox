module VirtualBox
  module FFI
    IUSBDEVICEFILTER_IID_STR = "d6831fb4-1a94-4c2c-96ef-8d0d6192066d"

    # Callbacks for IUSBDeviceFilter_vtbl
    callback :iudf_GetName, [:pointer, :pointer], NSRESULT_TYPE
    callback :iudf_SetName, [:pointer, :pointer], NSRESULT_TYPE
    callback :iudf_GetActive, [:pointer, :pointer], NSRESULT_TYPE
    callback :iudf_SetActive, [:pointer, PRBool], NSRESULT_TYPE
    callback :iudf_GetVendorId, [:pointer, :pointer], NSRESULT_TYPE
    callback :iudf_SetVendorId, [:pointer, :pointer], NSRESULT_TYPE
    callback :iudf_GetProductId, [:pointer, :pointer], NSRESULT_TYPE
    callback :iudf_SetProductId, [:pointer, :pointer], NSRESULT_TYPE
    callback :iudf_GetRevision, [:pointer, :pointer], NSRESULT_TYPE
    callback :iudf_SetRevision, [:pointer, :pointer], NSRESULT_TYPE
    callback :iudf_GetManufacturer, [:pointer, :pointer], NSRESULT_TYPE
    callback :iudf_SetManufacturer, [:pointer, :pointer], NSRESULT_TYPE
    callback :iudf_GetProduct, [:pointer, :pointer], NSRESULT_TYPE
    callback :iudf_SetProduct, [:pointer, :pointer], NSRESULT_TYPE
    callback :iudf_GetSerialNumber, [:pointer, :pointer], NSRESULT_TYPE
    callback :iudf_SetSerialNumber, [:pointer, :pointer], NSRESULT_TYPE
    callback :iudf_GetPort, [:pointer, :pointer], NSRESULT_TYPE
    callback :iudf_SetPort, [:pointer, :pointer], NSRESULT_TYPE
    callback :iudf_GetRemote, [:pointer, :pointer], NSRESULT_TYPE
    callback :iudf_SetRemote, [:pointer, :pointer], NSRESULT_TYPE
    callback :iudf_GetMaskedInterfaces, [:pointer, :pointer], NSRESULT_TYPE
    callback :iudf_SetMaskedInterfaces, [:pointer, :pointer], NSRESULT_TYPE

    class IUSBDeviceFilter < VTblParent
      parent_of :IUSBDeviceFilter_vtbl
    end

    class IUSBDeviceFilter_vtbl < VTbl
      define_layout do
        member :nsisupports, NSISupports_vtbl

        with_opts(:function_type_prefix => :iudf_) do
          member :GetName, :getter, :unicode_string
          member :SetName, :function, [:unicode_string]
          member :GetActive, :getter, PRBool
          member :SetActive, :function, [PRBool]
          member :GetVendorId, :getter, :unicode_string
          member :SetVendorId, :function, [:unicode_string]
          member :GetProductId, :getter, :unicode_string
          member :SetProductId, :function, [:unicode_string]
          member :GetRevision, :getter, :unicode_string
          member :SetRevision, :function, [:unicode_string]
          member :GetManufacturer, :getter, :unicode_string
          member :SetManufacturer, :function, [:unicode_string]
          member :GetProduct, :getter, :unicode_string
          member :SetProduct, :function, [:unicode_string]
          member :GetSerialNumber, :getter, :unicode_string
          member :SetSerialNumber, :function, [:unicode_string]
          member :GetPort, :getter, :unicode_string
          member :SetPort, :function, [:unicode_string]
          member :GetRemote, :getter, :unicode_string
          member :SetRemote, :function, [:unicode_string]
          member :GetMaskedInterfaces, :getter, :unicode_string
          member :SetMaskedInterfaces, :function, [:unicode_string]
        end
      end
    end
  end
end