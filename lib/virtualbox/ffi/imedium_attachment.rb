module VirtualBox
  module FFI
    IMEDIUMATTACHMENT_IID_STR = "e58eb3eb-8627-428b-bdf8-34487c848de5"

    # Function pointers for IMediumAttachment_vtbl
    callback :ima_GetMedium, [:pointer, :pointer], NSRESULT_TYPE
    callback :ima_GetController, [:pointer, :pointer], NSRESULT_TYPE
    callback :ima_GetPort, [:pointer, :pointer], NSRESULT_TYPE
    callback :ima_GetDevice, [:pointer, :pointer], NSRESULT_TYPE
    callback :ima_GetType, [:pointer, :pointer], NSRESULT_TYPE
    callback :ima_GetPassthrough, [:pointer, :pointer], NSRESULT_TYPE

    class IMediumAttachment < VTblParent
      parent_of :IMediumAttachment_vtbl
    end

    class IMediumAttachment_vtbl < VTbl
      define_layout do
        member :nsisupports, NSISupports_vtbl

        with_opts(:function_type_prefix => :ima_) do
          member :GetMedium, :getter, :IMedium
          member :GetController, :getter, :unicode_string
          member :GetPort, :getter, PRInt32
          member :GetDevice, :getter, PRInt32
          member :GetType, :getter, :DeviceType
          member :GetPassthrough, :getter, PRBool
        end
      end
    end
  end
end