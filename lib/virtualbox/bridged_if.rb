require 'virtualbox/interface'
module VirtualBox
  # Represents a single Bridged Interface.
  #
  # **Currently, new Bridged Interfaces can't be created or edited, so the only way to get this
  # object is through the global `bridged_ifs` relationship, and all it's attributes are readonly**
  #
  # # Attributes
  #
  # Properties of the model are exposed using standard ruby instance
  # methods which are generated on the fly. Because of this, they are not listed
  # below as available instance methods.
  #
  # These attributes can be accessed and modified via standard ruby-style
  # `instance.attribute` and `instance.attribute=` methods. The attributes are
  # listed below. If you aren't sure what this means or you can't understand
  # why the below is listed, please read {Attributable}.
  #
  #     attribute :name
  #     attribute :status
  #     attribute :macaddress
  #     attribute :dhcp
  #     attribute :ipaddress
  #     attribute :networkmask
  #     attribute :type
  #     attribute :vboxnetworkname
  #
  class BridgedIf < Interface
    
  end
end