module VirtualBox
  module FFI
    IAUDIOADAPTER_IID_STR = "921873db-5f3f-4b69-91f9-7be9e535a2cb"

    # Callbacks for IAudioAdapter_vtbl
    callback :iaa_GetEnabled, [:pointer, :pointer], NSRESULT_TYPE
    callback :iaa_SetEnabled, [:pointer, PRBool], NSRESULT_TYPE
    callback :iaa_GetAudioController, [:pointer, :pointer], NSRESULT_TYPE
    callback :iaa_SetAudioController, [:pointer, PRUint32], NSRESULT_TYPE
    callback :iaa_GetAudioDriver, [:pointer, :pointer], NSRESULT_TYPE
    callback :iaa_SetAudioDriver, [:pointer, PRUint32], NSRESULT_TYPE

    class IAudioAdapter < VTblParent
      parent_of :IAudioAdapter_vtbl
    end

    class IAudioAdapter_vtbl < VTbl
      define_layout do
        member :nsisupports, NSISupports_vtbl

        with_opts(:function_type_prefix => :iaa_) do
          member :GetEnabled, :getter, PRBool
          member :SetEnabled, :function, [PRBool]
          member :GetAudioController, :getter, PRUint32
          member :SetAudioController, :function, [PRUint32]
          member :GetAudioDriver, :getter, PRUint32
          member :SetAudioDriver, :getter, [PRUint32]
        end
      end
    end
  end
end