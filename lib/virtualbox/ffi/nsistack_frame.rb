module VirtualBox
  module FFI
    NS_ISTACKFRAME_IID_STR = "91d82105-7c62-4f8b-9779-154277c0ee90"

    # Callbacks for NSIStackFrame_vtbl
    callback :nsisf_GetLanguage, [:pointer, :pointer], NSRESULT_TYPE
    callback :nsisf_GetLanguageName, [:pointer, :pointer], NSRESULT_TYPE
    callback :nsisf_GetFilename, [:pointer, :pointer], NSRESULT_TYPE
    callback :nsisf_GetName, [:pointer, :pointer], NSRESULT_TYPE
    callback :nsisf_GetLineNumber, [:pointer, :pointer], NSRESULT_TYPE
    callback :nsisf_GetSourceLine, [:pointer, :pointer], NSRESULT_TYPE
    callback :nsisf_GetCaller, [:pointer, :pointer], NSRESULT_TYPE
    callback :nsisf_ToString, [:pointer, :pointer], NSRESULT_TYPE

    class NSIStackFrame < VTblParent
      parent_of :NSIStackFrame_vtbl
    end

    class NSIStackFrame_vtbl < VTbl
      define_layout do
        member :nsisupports, NSISupports_vtbl
        member :GetLanguage, :nsisf_GetLanguage
        member :GetLanguageName, :nsisf_GetLanguageName
        member :GetFilename, :nsisf_GetFilename
        member :GetName, :nsisf_GetName
        member :GetLineNumber, :nsisf_GetLineNumber
        member :GetSourceLine, :nsisf_GetSourceLine
        member :GetCaller, :nsisf_GetCaller
        member :ToString, :nsisf_ToString
      end
    end
  end
end