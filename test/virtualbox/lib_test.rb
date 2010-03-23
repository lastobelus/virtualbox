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

  context "xpcom, vbox, and session instances" do
    setup do
      @xpcom = mock("xpcom")
      @vbox = mock("vbox")
      @session = mock("session")
      VirtualBox::FFI.stubs(:init).returns([@xpcom, @vbox, @session])
    end

    context "getting xpcom instance" do
      setup do
        VirtualBox::Lib.reset!
      end

      should "call init on the first access" do
        VirtualBox::Lib.expects(:init).once
        VirtualBox::Lib.xpcom
      end

      should "call init on FFI only once" do
        VirtualBox::FFI.expects(:init).once.returns([@xpcom, @vbox, @session])
        xpcom = VirtualBox::Lib.xpcom
        assert_equal @xpcom, xpcom
        assert_equal xpcom, VirtualBox::Lib.xpcom
      end
    end

    context "getting vbox instance" do
      setup do
        VirtualBox::Lib.reset!
      end

      should "call init on the first access" do
        VirtualBox::Lib.expects(:init).once
        VirtualBox::Lib.vbox
      end

      should "call init on FFI only once" do
        VirtualBox::FFI.expects(:init).once.returns([@xpcom, @vbox, @session])
        vbox = VirtualBox::Lib.vbox
        assert_equal @vbox, vbox
        assert_equal vbox, VirtualBox::Lib.vbox
      end
    end

    context "getting session instance" do
      setup do
        VirtualBox::Lib.reset!
      end

      should "call init on the first access" do
        VirtualBox::Lib.expects(:init).once
        VirtualBox::Lib.session
      end

      should "call init on FFI only once" do
        VirtualBox::FFI.expects(:init).once.returns([@xpcom, @vbox, @session])
        session = VirtualBox::Lib.session
        assert_equal @session, session
        assert_equal session, VirtualBox::Lib.session
      end
    end
  end

  context "init-ing" do
    setup do
      @lib_path = "foo"
      VirtualBox::Lib.stubs(:lib_path).returns(@lib_path)
    end

    should "call init on FFI with the lib path" do
      VirtualBox::FFI.expects(:init).with(@lib_path).once
      VirtualBox::Lib.init
    end
  end
end