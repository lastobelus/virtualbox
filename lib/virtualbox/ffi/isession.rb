module VirtualBox
  module FFI
    ISESSION_IID_STR = "12F4DCDB-12B2-4EC1-B7CD-DDD9F6C5BF4D"

    # Callback types for ISession_vtbl
    callback :isess_GetState, [:pointer, :pointer], NSRESULT_TYPE
    callback :isess_GetType, [:pointer, :pointer], NSRESULT_TYPE
    callback :isess_GetMachine, [:pointer, :pointer], NSRESULT_TYPE
    callback :isess_GetConsole, [:pointer, :pointer], NSRESULT_TYPE
    callback :isess_Close, [:pointer], NSRESULT_TYPE

    class ISession < VTblParent
      parent_of :ISession_vtbl
    end

    class ISession_vtbl < VTbl
      define_layout do
        member :nsisupports, NSISupports_vtbl

        with_opts(:function_type_prefix => :isess_) do
          member :GetState, :getter, PRUint32
          member :GetType, :getter, PRUint32
          member :GetMachine, :getter, :IMachine
          member :GetConsole, :getter, :IConsole
          member :Close, :function, []
        end
      end
    end
  end
end