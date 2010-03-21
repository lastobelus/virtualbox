module VirtualBox
  module FFI
    # Callback types for ISession_vtbl
    callback :GetState, [:pointer, PRUint32], NSRESULT_TYPE
    callback :GetType, [:pointer, PRUint32], NSRESULT_TYPE
    callback :GetMachine, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetConsole, [:pointer, :pointer], NSRESULT_TYPE
    callback :Close, [:pointer], NSRESULT_TYPE

    class ISession < ::FFI::Struct
      layout :vtbl, :pointer # Pointer to ISession_vtbl
    end

    class ISession_vtbl < ::FFI::Struct
      layout  :nsisupports, NSISupports_vtbl,
              :GetState, :GetState,
              :GetType, :GetType,
              :GetMachine, :GetMachine,
              :GetConsole, :GetConsole,
              :Close, :Close
    end
  end
end