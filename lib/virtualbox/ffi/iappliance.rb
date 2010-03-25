module VirtualBox
  module FFI
    IAPPLIANCE_IID_STR = "e3ba9ab9-ac2c-4266-8bd2-91c4bf721ceb"

    # Callbacks for IAppliance_vtbl
    callback :ia_GetPath, [:pointer, :pointer], NSRESULT_TYPE
    callback :ia_GetDisks, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :ia_GetVirtualSystemDescriptions, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :ia_Read, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :ia_Interpret, [:pointer], NSRESULT_TYPE
    callback :ia_ImportMachines, [:pointer, :pointer], NSRESULT_TYPE
    callback :ia_CreateVFSExplorer, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :ia_Write, [:pointer, :pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :ia_GetWarnings, [:pointer, :pointer, :pointer], NSRESULT_TYPE

    class IAppliance < VTblParent
      parent_of :IAppliance_vtbl
    end

    class IAppliance_vtbl < VTbl
      define_layout do
        member :nsisupports, NSISupports_vtbl
        member :GetPath, :ia_GetPath
        member :GetDisks, :ia_GetDisks
        member :GetVirtualSystemDescriptions, :ia_GetVirtualSystemDescriptions
        member :Read, :ia_Read
        member :Interpret, :ia_Interpret
        member :ImportMachines, :ia_ImportMachines
        member :CreateVFSExplorer, :ia_CreateVFSExplorer
        member :Write, :ia_Write
        member :GetWarnings, :ia_GetWarnings
      end
    end
  end
end