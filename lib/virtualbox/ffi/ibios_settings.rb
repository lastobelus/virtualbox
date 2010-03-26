module VirtualBox
  module FFI
    IBIOSSETTINGS_IID_STR = "38b54279-dc35-4f5e-a431-835b867c6b5e"

    # Callbacks for IBIOSSettings_vtbl
    callback :ibs_GetLogoFadeIn, [:pointer, :pointer], NSRESULT_TYPE
    callback :ibs_SetLogoFadeIn, [:pointer, PRBool], NSRESULT_TYPE
    callback :ibs_GetLogoFadeOut, [:pointer, :pointer], NSRESULT_TYPE
    callback :ibs_SetLogoFadeOut, [:pointer, PRBool], NSRESULT_TYPE
    callback :ibs_GetLogoDisplayTime, [:pointer, :pointer], NSRESULT_TYPE
    callback :ibs_SetLogoDisplayTime, [:pointer, PRUint32], NSRESULT_TYPE
    callback :ibs_GetLogoImagePath, [:pointer, :pointer], NSRESULT_TYPE
    callback :ibs_SetLogoImagePath, [:pointer, :pointer], NSRESULT_TYPE
    callback :ibs_GetBootMenuMode, [:pointer, :pointer], NSRESULT_TYPE
    callback :ibs_SetBootMenuMode, [:pointer, PRUint32], NSRESULT_TYPE
    callback :ibs_GetACPIEnabled, [:pointer, :pointer], NSRESULT_TYPE
    callback :ibs_SetACPIEnabled, [:pointer, PRBool], NSRESULT_TYPE
    callback :ibs_GetIOAPICEnabled, [:pointer, :pointer], NSRESULT_TYPE
    callback :ibs_SetIOAPICEnabled, [:pointer, PRBool], NSRESULT_TYPE
    callback :ibs_GetTimeOffset, [:pointer, :pointer], NSRESULT_TYPE
    callback :ibs_SetTimeOffset, [:pointer, PRInt64], NSRESULT_TYPE
    callback :ibs_GetPXEDebugEnabled, [:pointer, :pointer], NSRESULT_TYPE
    callback :ibs_SetPXEDebugEnabled, [:pointer, PRBool], NSRESULT_TYPE

    class IBIOSSettings < VTblParent
      parent_of :IBIOSSettings_vtbl
    end

    class IBIOSSettings_vtbl < VTbl
      define_layout do
        member :nsisupports, NSISupports_vtbl

        with_opts(:function_type_prefix => :ibs_) do
          member :GetLogoFadeIn, :getter, PRBool
          member :SetLogoFadeIn, :function, [PRBool]
          member :GetLogoFadeOut, :getter, PRBool
          member :SetLogoFadeOut, :function, [PRBool]
          member :GetLogoDisplayTime, :getter, PRUint32
          member :SetLogoDisplayTime, :function, [PRUint32]
          member :GetLogoImagePath, :getter, :unicode_string
          member :SetLogoImagePath, :function, [:unicode_string]
          member :GetBootMenuMode, :getter, PRUint32
          member :SetBootMenuMode, :function, [PRUint32]
          member :GetACPIEnabled, :getter, PRBool
          member :SetACPIEnabled, :function, [PRBool]
          member :GetIOAPICEnabled, :getter, PRBool
          member :SetIOAPICEnabled, :function, [PRBool]
          member :GetTimeOffset, :getter, PRInt64
          member :SetTimeOffset, :function, [PRInt64]
          member :GetPXEDebugEnabled, :getter, PRBool
          member :SetPXEDebugEnabled, :function, [PRBool]
        end
      end
    end
  end
end