module VirtualBox
  module FFI
    ISESSION_IID_STR = "12F4DCDB-12B2-4EC1-B7CD-DDD9F6C5BF4D"

    # Callback types for ISession_vtbl
    callback :GetState, [:pointer, :pointer], NSRESULT_TYPE
    callback :GetType, [:pointer, :pointer], NSRESULT_TYPE
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