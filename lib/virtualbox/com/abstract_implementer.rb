module VirtualBox
  module COM
    # Base class for a COM interface implementer. Any child of this class is
    # responsible for properly handling the various method and propery calls
    # of a given {AbstractInterface} and making them do actual work.
    #
    # This abstraction is necessary to change the behavior of calls between
    # Windows (COM) and Unix (XPCOM), which have different calling conventions.
    class AbstractImplementer

    end
  end
end