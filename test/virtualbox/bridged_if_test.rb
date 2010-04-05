require File.join(File.dirname(__FILE__), '..', 'test_helper')

class BridgedIfTest < Test::Unit::TestCase
  setup do
    @caller = mock("caller")
    @caller.stubs(:name).returns("foo")
  end

  context "saving" do
    setup do
      VirtualBox::Command.expects(:vboxmanage).with("list", "bridgedifs").returns(mock_bridged_ifs_list)
      @bridged_if = VirtualBox::BridgedIf.populate_relationship(@caller, mock_xml_doc)
      @vmname = "myvm"
    end

    should "do nothing" do
      VirtualBox::Command.expects(:vboxmanage).never

      bridged_if = @bridged_if[0]
      assert_raises(NoMethodError) {bridged_if.name = "foo"}
      bridged_if.save(@vmname)
    end
  end

  context "populating relationships" do
    setup do
      @vmname = "myvm"
      VirtualBox::Command.expects(:vboxmanage).with("list", "bridgedifs").returns(mock_bridged_ifs_list)
      @value = VirtualBox::BridgedIf.populate_relationship(@caller, mock_xml_doc)
    end

    should "create the correct amount of objects" do
      assert_equal 2, @value.length
    end

    should "not be dirty initially" do
      assert !@value[0].changed?
    end

    should "be an existing record" do
      assert !@value[0].new_record?
    end

    should "parse the name" do
      assert_equal "en0: Ethernet", @value[0].name
      assert_equal "en1: AirPort", @value[1].name
    end

    should "parse the dhcp" do
      assert ! @value[0].dhcp
      assert @value[1].dhcp
    end

    should "parse the status" do
      assert @value[0].status
      assert ! @value[1].status
    end

    should "parse the ipaddress" do
      assert_equal "192.168.0.3", @value[1].ipaddress
    end

    should "parse the networkmask" do
      assert_equal "255.255.255.0", @value[0].networkmask
    end

    
  end
end