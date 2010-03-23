module VirtualBox
  module FFI
    # Callback types for VBOXXPCOMC
    callback :pfnGetVersion, [], :uint
    callback :pfnComInitialize, [:string, :pointer, :string, :pointer], :void
    callback :pfnComUninitialize, [], :void
    callback :pfnComUnallocMem, [:void], :void
    callback :pfnUtf16Free, [:pointer], :void
    callback :pfnUtf8Free, [:string], :void
    callback :pfnUtf16ToUtf8, [:pointer, :pointer], :int
    callback :pfnUtf8ToUtf16, [:pointer, :pointer], :int
    callback :pfnGetEventQueue, [:pointer], :void

    class VBOXXPCOMC < ::FFI::Struct
      layout  :cb, :uint,
              :uVersion, :uint,
              :pfnGetVersion, :pfnGetVersion,
              :pfnComInitialize, :pfnComInitialize,
              :pfnComUninitialize, :pfnComUninitialize,
              :pfnComUnallocMem, :pfnComUnallocMem,
              :pfnUtf16Free, :pfnUtf16Free,
              :pfnUtf8Free, :pfnUtf8Free,
              :pfnUtf16ToUtf8, :pfnUtf16ToUtf8,
              :pfnUtf8ToUtf16, :pfnUtf8ToUtf16,
              :pfnGetEventQueue, :pfnGetEventQueue,
              :uEndVersion, :uint

      # Initialiazes the VirtualBox XPCOM C interface, and returns the
      # {IVirtualBox} and {ISession} instances.
      #
      # @return [Array] IVIrtualBox and ISession instance, respectively
      def pfnComInitialize
        vbox_ptr = ::FFI::MemoryPointer.new(:pointer)
        session_ptr = ::FFI::MemoryPointer.new(:pointer)

        self[:pfnComInitialize].call(IVIRTUALBOX_IID_STR, vbox_ptr, ISESSION_IID_STR, session_ptr)
        [IVirtualBox.new(vbox_ptr.get_pointer(0)), ISession.new(session_ptr.get_pointer(0))]
      end
    end
  end
end