module VirtualBox
  module FFI
    # Callback types for nsISupports_vtbl
    callback :QueryInterface, [:pointer, :pointer, :pointer], NSRESULT_TYPE
    callback :AddRef, [:pointer], NSRESULT_TYPE
    callback :Release, [:pointer], NSRESULT_TYPE

    class NSISupports_vtbl < ::FFI::Struct
      layout  :QueryInterface, :QueryInterface,
              :AddRef, :AddRef,
              :Release, :Release
    end

    class NSISupports < ::FFI::Struct
      layout :vtbl, :pointer # Pointer to NSISupports_vtbl
    end
  end
end