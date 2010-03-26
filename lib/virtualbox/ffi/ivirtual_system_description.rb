module VirtualBox
  module FFI
    IVIRTUALSYSTEMDESCRIPTION_IID_STR = "d7525e6c-531a-4c51-8e04-41235083a3d8"

    # Callbacks for IVirtualSystemDescription_vtbl
    callback :ivsd_GetCount, [:pointer, :pointer], NSRESULT_TYPE
    callback :ivsd_GetDescription, [:pointer, :pointer, :pointer, :pointer, :pointer, :pointer, :pointer, :pointer, :pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :ivsd_GetDescriptionByType, [:pointer, PRUint32, :pointer, :pointer, :pointer, :pointer, :pointer, :pointer, :pointer, :pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :ivsd_GetValuesByType, [:pointer, PRUint32, PRUint32, :pointer, :pointer], NSRESULT_TYPE
    callback :ivsd_SetFinalValues, [:pointer, PRUint32, :pointer, PRUint32, :pointer, PRUint32, :pointer], NSRESULT_TYPE
    callback :ivsd_AddDescription, [:pointer, PRUint32, :pointer, :pointer], NSRESULT_TYPE

    class IVirtualSystemDescription < VTblParent
      parent_of :IVirtualSystemDescription_vtbl
    end

    class IVirtualSystemDescription_vtbl < VTbl
      define_layout do
        member :nsisupports, NSISupports_vtbl
        member :GetCount, :ivsd_GetCount
        member :GetDescription, :ivsd_GetDescription
        member :GetDescriptionByType, :ivsd_GetDescriptionByType
        member :GetValuesByType, :ivsd_GetValuesByType
        member :SetFinalValues, :ivsd_SetFinalValues
        member :AddDescription, :ivsd_AddDescription
      end
    end
  end
end