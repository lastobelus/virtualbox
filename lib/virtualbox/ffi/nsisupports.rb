module VirtualBox
  module FFI
    # Callback types for nsISupports_vtbl
    callback :nsis_QueryInterface, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :nsis_AddRef, [:pointer], NSRESULT_TYPE
    callback :nsis_Release, [:pointer], NSRESULT_TYPE

    class NSISupports_vtbl < VTbl
      define_layout do
        member :QueryInterface, :nsis_QueryInterface
        member :AddRef, :nsis_AddRef
        member :Release, :nsis_Release
      end
    end

    class NSISupports < VTblParent
      parent_of :NSISupports_vtbl
    end
  end
end