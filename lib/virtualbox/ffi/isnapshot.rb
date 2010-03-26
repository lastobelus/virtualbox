module VirtualBox
  module FFI
    ISNAPSHOT_IID_STR = "1a2d0551-58a4-4107-857e-ef414fc42ffc"

    # Callbacks for ISnapshot_vtbl
    callback :iss_GetId, [:pointer, :pointer], NSRESULT_TYPE
    callback :iss_GetName, [:pointer, :pointer], NSRESULT_TYPE
    callback :iss_SetName, [:pointer, :pointer], NSRESULT_TYPE
    callback :iss_GetDescription, [:pointer, :pointer], NSRESULT_TYPE
    callback :iss_SetDescription, [:pointer, :pointer], NSRESULT_TYPE
    callback :iss_GetTimeStamp, [:pointer, :pointer], NSRESULT_TYPE
    callback :iss_GetOnline, [:pointer, :pointer], NSRESULT_TYPE
    callback :iss_GetMachine, [:pointer, :pointer], NSRESULT_TYPE
    callback :iss_GetParent, [:pointer, :pointer], NSRESULT_TYPE
    callback :iss_GetChildren, [:pointer, :pointer], NSRESULT_TYPE

    class ISnapshot < VTblParent
      parent_of :ISnapshot_vtbl
    end

    class ISnapshot_vtbl < VTbl
      define_layout do
        member :nsisupports, NSISupports_vtbl

        with_opts(:function_type_prefix => :iss_) do
          member :GetId, :getter, :unicode_string
          member :GetName, :getter, :unicode_string
          member :SetName, :function, [:unicode_string]
          member :GetDescription, :getter, :unicode_string
          member :SetDescription, :function, [:unicode_string]
          member :GetTimeStamp, :getter, PRInt64
          member :GetOnline, :getter, PRBool
          member :GetMachine, :getter, :IMachine
          member :GetParent, :getter, :ISnapshot
          member :GetChildren, :array_getter, :ISnapshot
        end
      end
    end
  end
end