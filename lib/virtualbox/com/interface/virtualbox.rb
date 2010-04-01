module VirtualBox
  module COM
    module Interface
      class VirtualBox < AbstractInterface
        function :create_machine, [WSTRING, WSTRING, WSTRING, WSTRING, [:out, :Machine]]
        property :version, :readonly => true
        property :revision, :readonly => true
      end
    end
  end
end
