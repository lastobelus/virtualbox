require File.join(File.dirname(__FILE__), '..', 'test_helper')

class LibTest < Test::Unit::TestCase
  context "the virtualbox library file path" do
    setup do
      VirtualBox::Lib.lib_path = nil
    end

    should "return the path if its set" do
      VirtualBox::Lib.lib_path = "foo"
      File.expects(:expand_path).with("foo").returns("foo")
      assert_equal "foo", VirtualBox::Lib.lib_path
    end

    should "return Mac-path if on mac" do
      result = "/Applications/VirtualBox.app/Contents/MacOS/VBoxXPCOMC.dylib"
      VirtualBox::Platform.stubs(:mac?).returns(true)

      expanded_result = result + result
      File.expects(:expand_path).with(result).returns(expanded_result)
      assert_equal expanded_result, VirtualBox::Lib.lib_path
    end

    should "return Windows-path if on windows" do
      result = "Unknown"
      VirtualBox::Platform.stubs(:mac?).returns(false)
      VirtualBox::Platform.stubs(:windows?).returns(true)

      expanded_result = result + result
      File.expects(:expand_path).with(result).returns(expanded_result)
      assert_equal expanded_result, VirtualBox::Lib.lib_path
    end

    should "return Linux-path if on linux" do
      result = "Unknown"
      VirtualBox::Platform.stubs(:mac?).returns(false)
      VirtualBox::Platform.stubs(:windows?).returns(false)
      VirtualBox::Platform.stubs(:linux?).returns(true)

      expanded_result = result + result
      File.expects(:expand_path).with(result).returns(expanded_result)
      assert_equal expanded_result, VirtualBox::Lib.lib_path
    end

    should "return 'unknown' otherwise" do
      result = "Unknown"
      VirtualBox::Platform.stubs(:mac?).returns(false)
      VirtualBox::Platform.stubs(:windows?).returns(false)
      VirtualBox::Platform.stubs(:linux?).returns(false)

      expanded_result = result + result
      File.expects(:expand_path).with(result).returns(expanded_result)
      assert_equal expanded_result, VirtualBox::Lib.lib_path
    end
  end

  context "accessing the lib" do
    setup do
      @lib_path = "foo"
      VirtualBox::Lib.stubs(:lib_path).returns(@lib_path)
      VirtualBox::Lib.reset!
    end

    should "create a new Lib instance with the lib path once" do
      instance = mock("instance")
      VirtualBox::Lib.expects(:new).once.returns(instance)
      assert_equal instance, VirtualBox::Lib.lib
      assert_equal instance, VirtualBox::Lib.lib
      assert_equal instance, VirtualBox::Lib.lib
    end
  end

  context "init-ing" do
    setup do
      @lib_path = "foo"
    end

    should "call init on FFI with the lib path" do
      VirtualBox::FFI.expects(:init).with(@lib_path).once
      VirtualBox::Lib.new(@lib_path)
    end
  end
end