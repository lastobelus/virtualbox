module VirtualBox
  module FFI
    # A struct which behaves simply as a parent to a *_vtbl class, such
    # as IMachine, which is a parent to IMachine_vtbl, and so on.
    class VTblParent < ::FFI::Struct
      class <<self
        # Sets up the structure and instance method for accessing the
        # vtbl of the struct. The `klass` specified as the only parameter
        # specifies the name of the vtbl class.
        def parent_of(klass)
          # Define the layout
          layout :vtbl, :pointer

          # Create the instance method to access the vtbl
          define_method :vtbl do
            @_vtbl ||= FFI.const_get(klass).new(self, self[:vtbl])
          end
        end
      end

      # Method missing simply forwards any methods to the vtbl child.
      # This allows methods to be called on VTblParents as if they were
      # their actual VTbls.
      def method_missing(method, *args, &block)
        vtbl.send(method, *args, &block)
      end
    end
  end
end