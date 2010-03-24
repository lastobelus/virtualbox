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
        member :GetFamilyId, :igt_GetFamilyId
        member :GetFamilyDescription, :igt_GetFamilyDescription
        member :GetId, :igt_GetId
        member :GetDescription, :igt_GetDescription
        member :GetIs64Bit, :igt_GetIs64Bit
        member :GetRecommendedIOAPIC, :igt_GetRecommendedIOAPIC
        member :GetRecommendedVirtEx, :igt_GetRecommendedVirtEx
        member :GetRecommendedRAM, :igt_GetRecommendedRAM
        member :GetRecommendedVRAM, :igt_GetRecommendedVRAM
        member :GetRecommendedHDD, :igt_GetRecommendedHDD
        member :GetAdapterType, :igt_GetAdapterType
      end
    end
  end
end