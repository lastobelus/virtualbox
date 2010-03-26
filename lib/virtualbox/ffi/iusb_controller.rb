module VirtualBox
  module FFI
    IUSBCONTROLLER_IID_STR = "238540fa-4b73-435a-a38e-4e1d9eab5c17"

    # Callback types for IUSBController_vtbl
    callback :iuc_GetEnabled, [:pointer, :pointer], NSRESULT_TYPE
    callback :iuc_SetEnabled, [:pointer, PRBool], NSRESULT_TYPE
    callback :iuc_GetEnabledEhci, [:pointer, :pointer], NSRESULT_TYPE
    callback :iuc_SetEnabledEhci, [:pointer, PRBool], NSRESULT_TYPE
    callback :iuc_GetUSBStandard, [:pointer, :pointer], NSRESULT_TYPE
    callback :iuc_GetDeviceFilters, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :iuc_CreateDeviceFilter, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :iuc_InsertDeviceFilter, [:pointer, PRUint32, :pointer], NSRESULT_TYPE
    callback :iuc_RemoveDeviceFilter, [:pointer, PRUint32, :pointer], NSRESULT_TYPE

    class IUSBController < VTblParent
      parent_of :IUSBController_vtbl
    end

    class IUSBController_vtbl < VTbl
      define_layout do
        member :nsisupports, NSISupports_vtbl

        with_opts(:function_type_prefix => :iuc_) do
          member :GetEnabled, :getter, PRBool
          member :SetEnabled, :function, [PRBool]
          member :GetEnabledEhci, :getter, PRBool
          member :SetEnabledEhci, :function, [PRBool]
          member :GetUSBStandard, :getter, PRUint16
          member :GetDeviceFilters, :array_getter, :IUSBDeviceFilter
          member :CreateDeviceFilter, :function, [:unicode_string, [:out, :IUSBDeviceFilter]]
          member :InsertDeviceFilter, :function, [PRUint32, :IUSBDeviceFilter]
          member :RemoveDeviceFilter, :function, [PRUint32, [:out, :IUSBDeviceFilter]]
        end
      end
    end
  end
end