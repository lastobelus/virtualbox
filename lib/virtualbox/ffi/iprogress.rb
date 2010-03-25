module VirtualBox
  module FFI
    IPROGRESS_IID_STR = "856aa038-853f-42e2-acf7-6e7b02dbe294"

    # Callbacks for IProgress_vtbl
    callback :ip_GetId, [:pointer, :pointer], NSRESULT_TYPE
    callback :ip_GetDescription, [:pointer, :pointer], NSRESULT_TYPE
    callback :ip_GetInitiator, [:pointer, :pointer], NSRESULT_TYPE
    callback :ip_GetCancelable, [:pointer, :pointer], NSRESULT_TYPE
    callback :ip_GetPercent, [:pointer, :pointer], NSRESULT_TYPE
    callback :ip_GetTimeRemaining, [:pointer, :pointer], NSRESULT_TYPE
    callback :ip_GetCompleted, [:pointer, :pointer], NSRESULT_TYPE
    callback :ip_GetCanceled, [:pointer, :pointer], NSRESULT_TYPE
    callback :ip_GetResultCode, [:pointer, :pointer], NSRESULT_TYPE
    callback :ip_GetErrorInfo, [:pointer, :pointer], NSRESULT_TYPE
    callback :ip_GetOperationCount, [:pointer, :pointer], NSRESULT_TYPE
    callback :ip_GetOperation, [:pointer, :pointer], NSRESULT_TYPE
    callback :ip_GetOperationDescription, [:pointer, :pointer], NSRESULT_TYPE
    callback :ip_GetOperationPercent, [:pointer, :pointer], NSRESULT_TYPE
    callback :ip_GetTimeout, [:pointer, :pointer], NSRESULT_TYPE
    callback :ip_SetTimeout, [:pointer, PRUint32], NSRESULT_TYPE
    callback :ip_SetCurrentOperationProgress, [:pointer, PRUint32], NSRESULT_TYPE
    callback :ip_SetNextOperation, [:pointer, :pointer, PRUint32], NSRESULT_TYPE
    callback :ip_WaitForCompletion, [:pointer, PRUint32], NSRESULT_TYPE
    callback :ip_WaitForOperationCompletion, [:pointer, PRUint32, PRUint32], NSRESULT_TYPE
    callback :ip_Cancel, [:pointer], NSRESULT_TYPE

    class IProgress < VTblParent
      parent_of :IProgress_vtbl
    end

    class IProgress_vtbl < VTbl
      define_layout do
        member :nsisupports, NSISupports_vtbl

        with_opts(:function_type_prefix => :ip_) do
          member :GetId, :getter, :unicode_string
          member :GetDescription, :getter, :unicode_string
          member :GetInitiator, :getter, :NSISupports
          member :GetCancelable, :getter, PRBool
          member :GetPercent, :getter, PRUint32
          member :GetTimeRemaining, :getter, PRInt32
          member :GetCompleted, :getter, PRBool
          member :GetCanceled, :getter, PRBool
          member :GetResultCode, :getter, PRInt32
          member :GetErrorInfo, :getter, :IVirtualBoxErrorInfo
          member :GetOperationCount, :getter, PRUint32
          member :GetOperation, :getter, PRUint32
          member :GetOperationDescription, :getter, :unicode_string
          member :GetOperationPercent, :getter, PRUint32
          member :GetTimeout, :getter, PRUint32
          member :SetTimeout, :function, [PRUint32]
          member :SetCurrentOperationProgress, :function, [PRUint32]
          member :SetNextOperation, :function, [:unicode_string, PRUint32]
          member :WaitForCompletion, :function, [PRInt32]
          member :WaitForOperationCompletion, :function, [PRUint32, PRInt32]
          member :Cancel, :function, []
        end
      end
    end
  end
end