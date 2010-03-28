require File.join(File.dirname(__FILE__), '..', 'test_helper')

class HardDriveTest < Test::Unit::TestCase
  setup do
    @klass = VirtualBox::HardDrive
  end

  context "device type" do
    should "be :hard_disk" do
      assert_equal :hard_disk, @klass.device_type
    end
  end

  context "retrieving all hard drives" do
    should "return an array of HardDrive objects" do
      media = mock("media")
      media.expects(:hard_drives).returns("foo")
      global = mock("global")
      global.expects(:media).returns(media)
      VirtualBox::Global.expects(:global).returns(global)
      assert_equal "foo", VirtualBox::HardDrive.all
    end
  end
end