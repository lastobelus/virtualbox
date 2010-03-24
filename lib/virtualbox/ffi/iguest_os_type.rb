module VirtualBox
  module FFI
    IGUESTOSTYPE_IID_STR = "cfe9e64c-4430-435b-9e7c-e3d8e417bd58"

    # Callbacks for IGuestOSType_vtbl
    callback :igt_GetFamilyId, [:pointer, :pointer], NSRESULT_TYPE
    callback :igt_GetFamilyDescription, [:pointer, :pointer], NSRESULT_TYPE
    callback :igt_GetId, [:pointer, :pointer], NSRESULT_TYPE
    callback :igt_GetDescription, [:pointer, :pointer], NSRESULT_TYPE
    callback :igt_GetIs64Bit, [:pointer, :pointer], NSRESULT_TYPE
    callback :igt_GetRecommendedIOAPIC, [:pointer, :pointer], NSRESULT_TYPE
    callback :igt_GetRecommendedVirtEx, [:pointer, :pointer], NSRESULT_TYPE
    callback :igt_GetRecommendedRAM, [:pointer, :pointer], NSRESULT_TYPE
    callback :igt_GetRecommendedVRAM, [:pointer, :pointer], NSRESULT_TYPE
    callback :igt_GetRecommendedHDD, [:pointer, :pointer], NSRESULT_TYPE
    callback :igt_GetAdapterType, [:pointer, :pointer], NSRESULT_TYPE

    class IGuestOSType < VTblParent
      parent_of :IGuestOSType_vtbl
    end

    class IGuestOSType_vtbl < VTbl
      define_layout do
        member :nsisupports, NSISupports_vtbl

        with_opts(:function_type_prefix => :igt_) do
          member :GetFamilyId, :getter, :unicode_string
          member :GetFamilyDescription, :getter, :unicode_string
          member :GetId, :getter, :unicode_string
          member :GetDescription, :getter, :unicode_string
          member :GetIs64Bit, :getter, PRBool
          member :GetRecommendedIOAPIC, :getter, PRBool
          member :GetRecommendedVirtEx, :getter, PRBool
          member :GetRecommendedRAM, :getter, PRUint32
          member :GetRecommendedVRAM, :getter, PRUint32
          member :GetRecommendedHDD, :getter, PRUint32
          member :GetAdapterType, :getter, PRUint32
        end
      end
    end
  end
end