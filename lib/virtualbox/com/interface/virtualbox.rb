module VirtualBox
  module COM
    module Interface
      class VirtualBox < AbstractInterface
        function :create_machine, :Machine, [WSTRING, WSTRING, WSTRING, WSTRING]
        property :version, WSTRING, :readonly => true
        property :revision, WSTRING, :readonly => true
      end
    end
  end
end
