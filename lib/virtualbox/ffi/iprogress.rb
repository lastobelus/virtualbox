module VirtualBox
  module FFI
    IPROGRESS_IID_STR = "856aa038-853f-42e2-acf7-6e7b02dbe294"

    # Callbacks for IProgress_vtbl
    callback :GetId, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetDescription, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetInitiator, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetCancelable, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetPercent, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetTimeRemaining, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetCompleted, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetCanceled, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetResultCode, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetErrorInfo, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetOperationCount, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetOperation, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetOperationDescription, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetOperationPercent, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetTimeout, [:pointer, :pointer], NSRESULT_TYPE
    callback :SetTimeout, [:pointer, PRUint32], NSRESULT_TYPE
    callback :SetCurrentOperationProgress, [:pointer, PRUint32], NSRESULT_TYPE
    callback :SetNextOperation, [:pointer, :pointer, PRUint32], NSRESULT_TYPE
    callback :WaitForCompletion, [:pointer, PRUint32], NSRESULT_TYPE
    callback :WaitForOperationCompletion, [:pointer, PRUint32, PRUint32], NSRESULT_TYPE
    callback :Cancel, [:pointer], NSRESULT_TYPE

    class IProgress < VTblParent
      parent_of :IProgress_vtbl
    end

    class IProgress_vtbl < VTbl
      define_layout do
        member :nsisupports, NSISupports_vtbl
        member :GetId, :getter, :unicode_string
        member :GetDescription, :getter, :unicode_string
        member :GetInitiator, :getter, :NSISupports
        member :GetCancelable, :getter, PRBool
        member :GetPercent, :getter, PRUint32
        member :GetTimeRemaining, :getter, PRInt32
        member :GetCompleted, :getter, PRBool
        member :GetCanceled, :getter, PRBool
        member :GetResultCode, :getter, PRInt32
        member :GetErrorInfo, :GetErrorInfo #TODO
        member :GetOperationCount, :getter, PRUint32
        member :GetOperation, :getter, PRUint32
        member :GetOperationDescription, :getter, :unicode_string
        member :GetOperationPercent, :getter, PRUint32
        member :GetTimeout, :getter, PRUint32
        member :SetTimeout, :SetTimeout
        member :SetCurrentOperationProgress, :SetCurrentOperationProgress
        member :SetNextOperation, :SetNextOperation
        member :WaitForCompletion, :WaitForCompletion
        member :WaitForOperationCompletion, :WaitForOperationCompletion
        member :Cancel, :Cancel
      end
    end
  end
end