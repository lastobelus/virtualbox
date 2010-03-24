module VirtualBox
  module FFI
    ISHAREDFOLDER_IID_STR = "64637bb2-9e17-471c-b8f3-f8968dd9884e"

    # Callbacks for ISharedFolder_vtbl
    callback :isf_GetName, [:pointer, :pointer], NSRESULT_TYPE
    callback :isf_GetHostPath, [:pointer, :pointer], NSRESULT_TYPE
    callback :isf_GetAccessible, [:pointer, :pointer], NSRESULT_TYPE
    callback :isf_GetWritable, [:pointer, :pointer], NSRESULT_TYPE
    callback :isf_GetLastAccessError, [:pointer, :pointer], NSRESULT_TYPE

    class ISharedFolder < VTblParent
      parent_of :ISharedFolder_vtbl
    end

    class ISharedFolder_vtbl < VTbl
      define_layout do
        member :nsisupports, NSISupports_vtbl

        with_opts(:function_type_prefix => :isf_) do
          member :GetName, :getter, :unicode_string
          member :GetHostPath, :getter, :unicode_string
          member :GetAccessible, :getter, PRBool
          member :GetWritable, :getter, PRBool
          member :GetLastAccessError, :getter, :unicode_string
        end
      end
    end
  end
end