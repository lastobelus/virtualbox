module VirtualBox
  module FFI
    NS_IEXCEPTION_IID_STR = "f3a8d3b4-c424-4edc-8bf6-8974c983ba78"

    # Callbacks for NSIException_vtbl
    callback :nsie_GetMessage, [:pointer, :pointer], NSRESULT_TYPE
    callback :nsie_GetResult, [:pointer, :pointer], NSRESULT_TYPE
    callback :nsie_GetName, [:pointer, :pointer], NSRESULT_TYPE
    callback :nsie_GetFilename, [:pointer, :pointer], NSRESULT_TYPE
    callback :nsie_GetLineNumber, [:pointer, :pointer], NSRESULT_TYPE
    callback :nsie_GetColumnNumber, [:pointer, :pointer], NSRESULT_TYPE
    callback :nsie_GetLocation, [:pointer, :pointer], NSRESULT_TYPE
    callback :nsie_GetInner, [:pointer, :pointer], NSRESULT_TYPE
    callback :nsie_GetData, [:pointer, :pointer], NSRESULT_TYPE
    callback :nsie_ToString, [:pointer, :pointer], NSRESULT_TYPE

    class NSIException < VTblParent
      parent_of :NSIException_vtbl
    end

    class NSIException_vtbl < VTbl
      define_layout do
        member :nsisupports, NSISupports_vtbl

        with_opts(:function_type_prefix => :nsie_) do
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
end