module VirtualBox
  module FFI
    IVIRTUALBOXERRORINFO_IID_STR = "4b86d186-407e-4f9e-8be8-e50061be8725"

    # Callbacks for IVirtualBoxErrorInfo_vtbl
    callback :GetResultCode, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetInterfaceID, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetComponent, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetText, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetNext, [:pointer, :pointer], NSRESULT_TYPE

    class IVirtualBoxErrorInfo < VTblParent
      parent_of :IVirtualBoxErrorInfo_vtbl
    end

    class IVirtualBoxErrorInfo_vtbl < VTbl
      define_layout do
        member :nsiexception, NSIException
        member :GetResultCode, :getter, PRInt32
        member :GetInterfaceID, :getter, :unicode_string
        member :GetComponent, :getter, :unicode_string
        member :GetText, :getter, :unicode_string
        member :GetNext, :getter, :IVirtualBoxErrorInfo
      end
    end
  end
end