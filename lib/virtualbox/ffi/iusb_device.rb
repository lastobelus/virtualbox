module VirtualBox
  module FFI
    IUSBDEVICE_IID_STR = "f8967b0b-4483-400f-92b5-8b675d98a85b"

    # Callbacks for IUSBDevice_vtbl
    callback :iud_GetId, [:pointer, :pointer], NSRESULT_TYPE
    callback :iud_GetVendorId, [:pointer, :pointer], NSRESULT_TYPE
    callback :iud_GetProductId, [:pointer, :pointer], NSRESULT_TYPE
    callback :iud_GetRevision, [:pointer, :pointer], NSRESULT_TYPE
    callback :iud_GetManufacturer, [:pointer, :pointer], NSRESULT_TYPE
    callback :iud_GetProduct, [:pointer, :pointer], NSRESULT_TYPE
    callback :iud_GetSerialNumber, [:pointer, :pointer], NSRESULT_TYPE
    callback :iud_GetAddress, [:pointer, :pointer], NSRESULT_TYPE
    callback :iud_GetPort, [:pointer, :pointer], NSRESULT_TYPE
    callback :iud_GetVersion, [:pointer, :pointer], NSRESULT_TYPE
    callback :iud_GetPortVersion, [:pointer, :pointer], NSRESULT_TYPE
    callback :iud_GetRemote, [:pointer, :pointer], NSRESULT_TYPE

    class IUSBDevice < VTblParent
      parent_of :IUSBDevice_vtbl
    end

    class IUSBDevice_vtbl < VTbl
      define_layout do
        member :nsisupports, NSISupports_vtbl

        with_opts(:function_type_prefix => :iud_) do
          member :GetId, :getter, :unicode_string
          member :GetVendorId, :getter, PRUint16
          member :GetProductId, :getter, PRUint16
          member :GetRevision, :getter, PRUint16
          member :GetManufacturer, :getter, :unicode_string
          member :GetProduct, :getter, :unicode_string
          member :GetSerialNumber, :getter, :unicode_string
          member :GetAddress, :getter, :unicode_string
          member :GetPort, :getter, PRUint16
          member :GetVersion, :getter, PRUint16
          member :GetPortVersion, :getter, PRUint16
          member :GetRemote, :getter, PRBool
        end
      end
    end
  end
end