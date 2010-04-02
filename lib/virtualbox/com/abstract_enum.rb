module VirtualBox
  module COM
    # Represents a C enum type. Provides functionality to easily convert
    # an int value to its proper symbol within the enum.
    class AbstractEnum
      class <<self
        # Defines the mapping of int => symbol for the given Enum.
        # The parameter to this can be an Array or Hash or anything which
        # can be indexed with `[]` and an integer and returns a value of
        # some sort.
        def map(value)
          @map = value
        end

        # Returns the symbol associatd with the given key
        def [](key)
          @map[key]
        end

        # Returns the index associated with a value
        def index(key)
          @map.index(key)
        end

        # Provided mostly for testing purposes only, but resets the mapping
        # to nil.
        def reset!
          @map = nil
        end
      end
    end
  end
end