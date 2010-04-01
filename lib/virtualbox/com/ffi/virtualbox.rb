=begin
module VirtualBox
  module COM
    module FFI
      class VirtualBox < Interface(:NSISupports)
        parent :
        com_interface :VirtualBox
        function :create_machine, [WSTRING, WSTRING, WSTRING, WSTRING, [:out, :Machine]]
        property :version, :readonly => true
        property :revision, :readonly => true
      end
    end
  end
end
=end