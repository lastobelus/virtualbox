module VirtualBox
  module FFI
    ICONSOLE_IID_STR = "6375231a-c17c-464b-92cb-ae9e128d71c3"

    # Callbacks for IConsole_vtbl
    callback :icon_GetMachine, [:pointer, :pointer], NSRESULT_TYPE
    callback :icon_GetState, [:pointer, :pointer], NSRESULT_TYPE
    callback :icon_GetGuest, [:pointer, :pointer], NSRESULT_TYPE
    callback :icon_GetKeyboard, [:pointer, :pointer], NSRESULT_TYPE
    callback :icon_GetMouse, [:pointer, :pointer], NSRESULT_TYPE
    callback :icon_GetDisplay, [:pointer, :pointer], NSRESULT_TYPE
    callback :icon_GetDebugger, [:pointer, :pointer], NSRESULT_TYPE
    callback :icon_GetUSBDevices, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :icon_GetRemoteUSBDevices, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :icon_GetSharedFolders, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :icon_GetRemoteDisplayInfo, [:pointer, :pointer], NSRESULT_TYPE
    callback :icon_PowerUp, [:pointer, :pointer], NSRESULT_TYPE
    callback :icon_PowerUpPaused, [:pointer, :pointer], NSRESULT_TYPE
    callback :icon_PowerDown, [:pointer, :pointer], NSRESULT_TYPE
    callback :icon_Reset, [:pointer], NSRESULT_TYPE
    callback :icon_Pause, [:pointer], NSRESULT_TYPE
    callback :icon_Resume, [:pointer], NSRESULT_TYPE
    callback :icon_PowerButton, [:pointer], NSRESULT_TYPE
    callback :icon_SleepButton, [:pointer], NSRESULT_TYPE
    callback :icon_GetPowerButtonHandled, [:pointer, :pointer], NSRESULT_TYPE
    callback :icon_GetGuestEnteredACPIMode, [:pointer, :pointer], NSRESULT_TYPE
    callback :icon_SaveState, [:pointer, :pointer], NSRESULT_TYPE
    callback :icon_AdoptSavedState, [:pointer, :pointer], NSRESULT_TYPE
    callback :icon_ForgetSavedState, [:pointer, PRBool], NSRESULT_TYPE
    callback :icon_GetDeviceActivity, [:pointer, PRUint32, :pointer], NSRESULT_TYPE
    callback :icon_AttachUSBDevice, [:pointer, :pointer], NSRESULT_TYPE
    callback :icon_DetachUSBDevice, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :icon_FindUSBDeviceByAddress, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :icon_FindUSBDeviceById, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :icon_CreateSharedFolder, [:pointer,  :pointer, :pointer, PRBool], NSRESULT_TYPE
    callback :icon_RemoveSharedFolder, [:pointer, :pointer], NSRESULT_TYPE
    callback :icon_TakeSnapshot, [:pointer, :pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :icon_DeleteSnapshot, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :icon_RestoreSnapshot, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :icon_Teleport, [:pointer, :pointer, PRUint32, :pointer, PRUint32, :pointer], NSRESULT_TYPE
    callback :icon_RegisterCallback, [:pointer, :pointer], NSRESULT_TYPE
    callback :icon_UnregisterCallback, [:pointer, :pointer], NSRESULT_TYPE

    class IConsole < VTblParent
      parent_of :IConsole_vtbl
    end

    class IConsole_vtbl < VTbl
      define_layout do
        member :nsisupports, NSISupports_vtbl

        with_opts(:function_type_prefix => :icon_) do
          member :GetMachine, :getter, :IMachine
          member :GetState, :getter, :MachineState
          member :GetGuest, :getter, :IGuest
          member :GetKeyboard, :getter, :IKeyboard
          member :GetMouse, :getter, :IMouse
          member :GetDisplay, :getter, :IDisplay
          member :GetDebugger, :getter, :IMachineDebugger
          member :GetUSBDevices, :array_getter, :IUSBDevice
          member :GetRemoteUSBDevices, :array_getter, :IHostUSBDevice
          member :GetSharedFolders, :array_getter, :ISharedFolder
          member :GetRemoteDisplayInfo, :getter, :IRemoteDisplayInfo
          member :PowerUp, :getter, :IProgress
          member :PowerUpPaused, :getter, :IProgress
          member :PowerDown, :getter, :IProgress
          member :Reset, :function, []
          member :Pause, :function, []
          member :Resume, :function, []
          member :PowerButton, :function, []
          member :SleepButton, :function, []
          member :GetPowerButtonHandled, :getter, PRBool
          member :GetGuestEnteredACPIMode, :getter, PRBool
          member :SaveState, :getter, :IProgress
          member :AdoptSavedState, :function, [:unicode_string]
          member :ForgetSavedState, :function, [PRBool]
          member :GetDeviceActivity, :function, [PRUint32, [:out, PRUint32]]
          member :AttachUSBDevice, :function, [:unicode_string]
          member :DetachUSBDevice, :function, [:unicode_string, [:out, :IUSBDevice]]
          member :FindUSBDeviceByAddress, :function, [:unicode_string, [:out, :IUSBDevice]]
          member :FindUSBDeviceById, :function, [:unicode_string, [:out, :IUSBDevice]]
          member :CreateSharedFolder, :function, [:unicode_string, :unicode_string, PRBool]
          member :RemoveSharedFolder, :function, [:unicode_string]
          member :TakeSnapshot, :function, [:unicode_string, :unicode_string, [:out, :IProgress]]
          member :DeleteSnapshot, :function, [:unicode_string, [:out, :IProgress]]
          member :RestoreSnapshot, :function, [:ISnapshot, [:out, :IProgress]]
          member :Teleport, :function, [:unicode_string, PRUint32, :unicode_string, PRUint32, [:out, :IProgress]]
          member :RegisterCallback, :function, [:IConsoleCallback]
          member :UnregisterCallback, :function, [:IConsoleCallback]
        end
      end
    end
  end
end