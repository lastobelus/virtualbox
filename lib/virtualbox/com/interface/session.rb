module VirtualBox
  module COM
    module Interface
      class Session < AbstractInterface
        property :state, :SessionState, :readonly => true
        property :type, :SessionType, :readonly => true
        property :machine, :Machine, :readonly => true
        property :console, :Console, :readonly => true

        function :close, nil, []
      end
    end
  end
end
