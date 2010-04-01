require File.join(File.dirname(__FILE__), '..', '..', '..', 'test_helper')

class COMImplementerFFITest < Test::Unit::TestCase
  setup do
    @klass = VirtualBox::COM::Implementer::FFI
  end

  context "initializing" do
    setup do
      @interface = mock("interface")
      @interface.stubs(:class).returns(VirtualBox::COM::Interface::Session)

      @pointer = mock("pointer")
    end

    should "initialize the FFI interface associated with the AbstractInterface" do
      result = mock("result")
      VirtualBox::COM::FFI::Session.expects(:new).with(@pointer).once.returns(result)
      instance = @klass.new(@interface, @pointer)
      assert_equal result, instance.ffi_interface
    end
  end
end