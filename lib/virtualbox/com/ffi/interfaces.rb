module VirtualBox
  module COM
    module FFI
      # Creates all the interfaces for the FFI implementation. Eventually this
      # file should be conditionally loaded based on OS, so that Windows users
      # don't have to wait for all this translation to occur.
      create_interface(:NSISupports)
      create_interface(:VirtualBox, :NSISupports)
    end
  end
end