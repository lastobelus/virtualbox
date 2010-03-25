module VirtualBox
  module FFI
    IHOSTUSBDEVICE_IID_STR = "173b4b44-d268-4334-a00d-b6521c9a740a"

    # Callbacks for IHostUSBDevice_vtbl
    callback :ihud_GetState, [:pointer, :pointer], NSRESULT_TYPE

    class IHostUSBDevice < VTblParent
      parent_of :IHostUSBDevice_vtbl
    end

    class IHostUSBDevice_vtbl < VTbl
      define_layout do
        member :iusbdevice, IUSBDevice_vtbl
        member :GetState, :getter, PRUint32, :function_type_prefix => :ihud_
      end
    end
  end
end