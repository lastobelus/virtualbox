module VirtualBox
  module FFI
    ISERIALPORT_IID_STR = "937f6970-5103-4745-b78e-d28dcf1479a8"

    # Callbacks for ISerialPort_vtbl
    callback :isp_GetSlot, [:pointer, :pointer], NSRESULT_TYPE
    callback :isp_GetEnabled, [:pointer, :pointer], NSRESULT_TYPE
    callback :isp_SetEnabled, [:pointer, PRBool], NSRESULT_TYPE
    callback :isp_GetIOBase, [:pointer, :pointer], NSRESULT_TYPE
    callback :isp_SetIOBase, [:pointer, PRUint32], NSRESULT_TYPE
    callback :isp_GetIRQ, [:pointer, :pointer], NSRESULT_TYPE
    callback :isp_SetIRQ, [:pointer, PRUint32], NSRESULT_TYPE
    callback :isp_GetHostMode, [:pointer, :pointer], NSRESULT_TYPE
    callback :isp_SetHostMode, [:pointer, PRUint32], NSRESULT_TYPE
    callback :isp_GetServer, [:pointer, :pointer], NSRESULT_TYPE
    callback :isp_SetServer, [:pointer, PRBool], NSRESULT_TYPE
    callback :isp_GetPath, [:pointer, :pointer], NSRESULT_TYPE
    callback :isp_SetPath, [:pointer, :pointer], NSRESULT_TYPE

    class ISerialPort < VTblParent
      parent_of :ISerialPort_vtbl
    end

    class ISerialPort_vtbl < VTbl
      define_layout do
        member :nsisupports, NSISupports_vtbl

        with_opts(:function_type_prefix => :isp_) do
          member :GetSlot, :getter, PRUint32
          member :GetEnabled, :getter, PRBool
          member :SetEnabled, :function, [PRBool]
          member :GetIOBase, :getter, PRUint32
          member :SetIOBase, :function, [PRUint32]
          member :GetIRQ, :getter, PRUint32
          member :SetIRQ, :function, [PRUint32]
          member :GetHostMode, :getter, PRUint32
          member :SetHostMode, :function, [PRUint32]
          member :GetServer, :getter, PRBool
          member :SetServer, :function, [PRBool]
          member :GetPath, :getter, :unicode_string
          member :SetPath, :function, [:unicode_string]
        end
      end
    end
  end
end