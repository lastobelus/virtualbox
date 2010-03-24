module VirtualBox
  module FFI
    NS_IEXCEPTION_IID_STR = "f3a8d3b4-c424-4edc-8bf6-8974c983ba78"

    # Callbacks for NSIException_vtbl
    callback :GetMessage, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetResult, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetName, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetFilename, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetLineNumber, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetColumnNumber, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetLocation, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetInner, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetData, [:pointer, :pointer], NSRESULT_TYPE
    callback :ToString, [:pointer, :pointer], NSRESULT_TYPE

    class NSIException < VTblParent
      parent_of :NSIException_vtbl
    end

    class NSIException_vtbl < VTbl
      define_layout do
        member :nsisupports, NSISupports_vtbl
        member :GetMessage, :getter, :unicode_string
        member :GetResult, :getter, NSRESULT_TYPE
        member :GetName, :getter, :unicode_string
        member :GetFilename, :getter, :unicode_string
        member :GetLineNumber, :getter, PRUint32
        member :GetColumnNumber, :getter, PRUint32
        member :GetLocation, :getter, :NSIStackFrame
        member :GetInner, :getter, :NSIException
        member :GetData, :getter, :NSISupports
        member :ToString, :getter, :unicode_string
      end
    end
  end
end