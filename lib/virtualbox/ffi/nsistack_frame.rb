module VirtualBox
  module FFI
    NS_ISTACKFRAME_IID_STR = "91d82105-7c62-4f8b-9779-154277c0ee90"

    # Callbacks for NSIStackFrame_vtbl
    callback :GetLanguage, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetLanguageName, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetFilename, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetName, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetLineNumber, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetSourceLine, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetCaller, [:pointer, :pointer], NSRESULT_TYPE
    callback :ToString, [:pointer, :pointer], NSRESULT_TYPE

    class NSIStackFrame < VTblParent
      parent_of :NSIStackFrame_vtbl
    end

    class NSIStackFrame_vtbl < VTbl
      define_layout do
        member :nsisupports, NSISupports_vtbl
        member :GetLanguage, :GetLanguage
        member :GetLanguageName, :GetLanguageName
        member :GetFilename, :GetFilename
        member :GetName, :GetName
        member :GetLineNumber, :GetLineNumber
        member :GetSourceLine, :GetSourceLine
        member :GetCaller, :GetCaller
        member :ToString, :ToString
      end
    end
  end
end