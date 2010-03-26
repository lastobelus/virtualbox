module VirtualBox
  module FFI
    IPARALLELPORT_IID_STR = "0c925f06-dd10-4b77-8de8-294d738c3214"

    # Callbacks for IParallelPort_vtbl
    callback :ipp_GetSlot, [:pointer, :pointer], NSRESULT_TYPE
    callback :ipp_GetEnabled, [:pointer, :pointer], NSRESULT_TYPE
    callback :ipp_SetEnabled, [:pointer, PRBool], NSRESULT_TYPE
    callback :ipp_GetIOBase, [:pointer, :pointer], NSRESULT_TYPE
    callback :ipp_SetIOBase, [:pointer, PRUint32], NSRESULT_TYPE
    callback :ipp_GetIRQ, [:pointer, :pointer], NSRESULT_TYPE
    callback :ipp_SetIRQ, [:pointer, PRUint32], NSRESULT_TYPE
    callback :ipp_GetPath, [:pointer, :pointer], NSRESULT_TYPE
    callback :ipp_SetPath, [:pointer, :pointer], NSRESULT_TYPE

    class IParallelPort < VTblParent
      parent_of :IParallelPort_vtbl
    end

    class IParallelPort_vtbl < VTbl
      define_layout do
        member :nsisupports, NSISupports_vtbl

        with_opts(:function_type_prefix => :ipp_) do
          member :GetSlot, :getter, PRUint32
          member :GetEnabled, :getter, PRBool
          member :SetEnabled, :function, [PRBool]
          member :GetIOBase, :getter, PRUint32
          member :SetIOBase, :function, [PRUint32]
          member :GetIRQ, :getter, PRUint32
          member :SetIRQ, :function, [PRUint32]
          member :GetPath, :getter, :unicode_string
          member :SetPath, :function, [:unicode_string]
        end
      end
    end
  end
end