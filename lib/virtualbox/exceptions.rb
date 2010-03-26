module VirtualBox
  # Gem specific exceptions will reside under this namespace for easy
  # documentation and searching.
  module Exceptions
    class Exception < ::Exception; end

    class CommandFailedException < Exception; end
    class ConfigurationException < Exception; end
    class InvalidRelationshipObjectException < Exception; end
    class NonSettableRelationshipException < Exception; end
    class ValidationFailedException < Exception; end

    class FFIException < Exception
      attr_accessor :data

      def initialize(data={})
        @data = data
        super("Error in API call to #{data[:function]}: #{data[:result_code]}")
      end
    end

    # FFI Exceptions
    class ObjectNotFoundException < FFIException; end
    class InvalidVMStateException < FFIException; end
    class VMErrorException < FFIException; end
    class FileErrorException < FFIException; end
    class SubsystemException < FFIException; end
    class PDMException < FFIException; end
    class InvalidObjectStateException < FFIException; end
    class HostErrorException < FFIException; end
    class NotSupportedException < FFIException; end
    class XMLErrorException < FFIException; end
    class InvalidSessionStateException < FFIException; end
    class ObjectInUseException < FFIException; end
  end
end