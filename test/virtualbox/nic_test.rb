require File.join(File.dirname(__FILE__), '..', 'test_helper')

class NicTest < Test::Unit::TestCase
  setup do
    @caller = mock("caller")
    @caller.stubs(:name).returns("foo")
  end

  context "saving" do
    setup do
      @nic = VirtualBox::Nic.populate_relationship(@caller, mock_xml_doc)
      @vmname = "myvm"
    end

    should "use the vmname strung through the save" do
      VirtualBox::Command.expects(:vboxmanage).with("modifyvm", @vmname, "--nic1", "foo")

      nic = @nic[0]
      nic.nic = "foo"
      nic.save(@vmname)
    end

    should "use the proper index" do
      VirtualBox::Command.expects(:vboxmanage).with("modifyvm", @vmname, "--nic2", "far")

      nic = @nic[1]
      nic.nic = "far"
      nic.save(@vmname)
    end

    should "save the nictype" do
      VirtualBox::Command.expects(:vboxmanage).with("modifyvm", @vmname, "--nictype1", "ZOO")

      nic = @nic[0]
      nic.nictype = "ZOO"
      assert nic.nictype_changed?
      nic.save(@vmname)
    end

    should "save with a bridged nic" do
      VirtualBox::Command.expects(:vboxmanage).with("modifyvm", @vmname, "--nic1", "bridged")
      VirtualBox::Command.expects(:vboxmanage).with("modifyvm", @vmname, "--bridgeadapter1", "Bob")
      nic = @nic[0]
      nic.attach_to_bridged_interface("Bob")
      assert nic.nic_changed?
      assert nic.interfacename_changed?
      nic.save(@vmname)
    end
    
    should "save with a host_only nic" do
      VirtualBox::Command.expects(:vboxmanage).with("modifyvm", @vmname, "--nic1", "hostonly")
      VirtualBox::Command.expects(:vboxmanage).with("modifyvm", @vmname, "--hostonlyadapter1", "Bob")
      nic = @nic[0]
      nic.attach_to_host_only_interface("Bob")
      assert nic.nic_changed?
      assert nic.interfacename_changed?
      nic.save(@vmname)
    end
    
    should "save with a internal network nic" do
      VirtualBox::Command.expects(:vboxmanage).with("modifyvm", @vmname, "--nic1", "intnet")
      VirtualBox::Command.expects(:vboxmanage).with("modifyvm", @vmname, "--intnet1", "Bob")
      nic = @nic[0]
      nic.attach_to_internal_network("Bob")
      assert nic.nic_changed?
      assert nic.interfacename_changed?
      nic.save(@vmname)
    end
    
    
    should "raise a CommandFailedException if it fails" do
      VirtualBox::Command.stubs(:vboxmanage).raises(VirtualBox::Exceptions::CommandFailedException)

      nic = @nic[0]
      nic.nictype = "ZOO"
      assert_raises(VirtualBox::Exceptions::CommandFailedException) {
        nic.save(@vmname)
      }
    end
  end

  context "populating relationships" do
    setup do
      @value = VirtualBox::Nic.populate_relationship(@caller, mock_xml_doc)
    end

    should "create the correct amount of objects" do
      assert_equal 8, @value.length
    end

    should "not be dirty initially" do
      assert !@value[0].changed?
    end

    should "be an existing record" do
      assert !@value[0].new_record?
    end

    should "parse the type" do
      assert_equal "Am79C973", @value[0].nictype
    end

    should "correctly turn adapters which aren't enabled into 'none'" do
      assert_equal "none", @value[2].nic
    end
  end
end