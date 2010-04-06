require File.join(File.dirname(__FILE__), '..', 'test_helper')

class HostOnlyIfTest < Test::Unit::TestCase
  setup do
    @caller = mock("caller")
    @caller.stubs(:name).returns("foo")
  end

  context "saving" do
    setup do
      VirtualBox::Command.expects(:vboxmanage).with("list", "hostonlyifs").returns(mock_host_only_ifs_list)
      @hostonly_if = VirtualBox::HostOnlyIf.populate_relationship(@caller, mock_xml_doc)
      @vmname = "myvm"
    end

    should "do nothing" do
      VirtualBox::Command.expects(:vboxmanage).never

      hostonly_if = @hostonly_if[0]
      assert_raises(NoMethodError) {hostonly_if.name = "foo"}
      hostonly_if.save(@vmname)
    end
  end

  context "populating relationships" do
    setup do
      @vmname = "myvm"
      VirtualBox::Command.expects(:vboxmanage).with("list", "hostonlyifs").returns(mock_host_only_ifs_list)
      @value = VirtualBox::HostOnlyIf.populate_relationship(@caller, mock_xml_doc)
    end

    should "create the correct amount of objects" do
      assert_equal 1, @value.length
    end

    should "not be dirty initially" do
      assert !@value[0].changed?
    end

    should "be an existing record" do
      assert !@value[0].new_record?
    end

    should "parse the name" do
      assert_equal "vboxnet0", @value[0].name
    end

    should "parse the dhcp" do
      assert ! @value[0].dhcp
    end

    should "parse the status" do
      assert ! @value[0].status
    end

    should "parse the ipaddress" do
      assert_equal "192.168.56.1", @value[0].ipaddress
    end

    should "parse the networkmask" do
      assert_equal "255.255.255.0", @value[0].networkmask
    end

    
  end
end