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
        member :GetMessage, :GetMessage
        member :GetResult, :GetResult
        member :GetName, :GetName
        member :GetFilename, :GetFilename
        member :GetLineNumber, :GetLineNumber
        member :GetColumnNumber, :GetColumnNumber
        member :GetLocation, :GetLocation
        member :GetInner, :GetInner
        member :GetData, :GetData
        member :ToString, :ToString
      end
    end
  end
end