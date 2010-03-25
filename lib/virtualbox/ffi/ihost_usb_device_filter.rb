module VirtualBox
  module FFI
    IHOSTUSBDEVICEFILTER_IID_STR = "4cc70246-d74a-400f-8222-3900489c0374"

    # Callbacks for IHostUSBDeviceFilter_vtbl
    callback :ihudf_GetAction, [:pointer, :pointer], NSRESULT_TYPE
    callback :ihudf_SetAction, [:pointer, PRUint32], NSRESULT_TYPE

    class IHostUSBDeviceFilter < VTblParent
      parent_of :IHostUSBDeviceFilter_vtbl
    end

    class IHostUSBDeviceFilter_vtbl < VTbl
      define_layout do
        member :iusbdevicefilter, IUSBDeviceFilter

        with_opts(:function_type_prefix => :ihudf_) do
          member :GetAction, :getter, PRUint32
          member :SetAction, :function, [PRUint32]
        end
      end
    end
  end
end