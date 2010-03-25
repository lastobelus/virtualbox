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

        with_opts(:function_type_prefix => :ia_) do
          member :GetPath, :getter, :unicode_string
          member :GetDisks, :array_getter, :unicode_string
          member :GetVirtualSystemDescriptions, :array_getter, :IVirtualSystemDescription
          member :Read, :function, [:unicode_string, [:out, :IProgress]]
          member :Interpret, :function, []
          member :ImportMachines, :function, [[:out, :IProgress]]
          member :CreateVFSExplorer, :function, [:unicode_string, [:out, :IVFSExplorer]]
          member :Write, :function, [:unicode_string, :unicode_string, [:out, :IProgress]]
          member :GetWarnings, :array_getter, :unicode_string
        end
      end
    end
  end
end