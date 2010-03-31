module VirtualBox
  module COM
    # Base class for a COM (component object model) interface class. This
    # abstraction is necessary to maintain a common ground between
    # Windows COM usage and the VirtualBox C API for unix based systems.
    #
    # # Defining an Interface
    #
    # Defining an interface is done by subclassing AbstractInterface and
    # using the provided class methods to define the COM methods and
    # properties. A small example class is shown below:
    #
    #     class Time < AbstractInterface
    #       function :now, [[:out, :uint]]
    #       property :hour, :uint
    #     end
    #
    # # Accessing an Interface
    #
    # Interfaces are never accessed directly. Instead, an {InterfaceRunner}
    # should be used. Depending on the OS of the running system, the VirtualBox
    # gem will automatically either load the MSCOM interface (on Windows)
    # or the XPCOM interface (on Unix). One loaded, interfaces can simply be
    # accessed:
    #
    #     # Assume `time` was retrieved already
    #     puts time.foo.to_s
    #     time.hour = 20
    #     x = time.now
    #
    # The above example shows how the properties and functions can be used
    # with a given interface.
    #
    class AbstractInterface
      class <<self
        # Adds a function to the interface with the given name and function
        # spec. The spec determines the arguments required, the order they
        # are required in, and any out-arguments.
        def function(name, spec, opts={})
          members[name] = {
            :type => :function,
            :spec => spec,
            :opts => opts
          }

          # Define the method to call the function
          define_method(name) { call_function(name) }
        end

        # Adds a property to the interface with the given name, type, and
        # options.
        def property(name, type, opts={})
          members[name] = {
            :type => :property,
            :value_type => type,
            :opts => opts
          }

          # Define the method to read the property
          define_method(name) { read_property(name) }

          # Define method to write the property
          define_method("#{name}=".to_sym) { write_property(name) } unless opts[:readonly]
        end

        # Returns the members of the interface as a hash. This hash contains
        # both properties and functions (specified by the :type key in the value
        # of a member).
        #
        # @return [Hash]
        def members
          @members ||= {}
        end
      end

      # Returns a boolean if a given property exists or not.
      def has_property?(name)
        members.has_key?(name) && members[name][:type] == :property
      end

      # Returns the members of the interface as a hash. This simply calls
      # {AbstractInterface.members}.
      def members
        self.class.members
      end
    end
  end
end