require File.join(File.dirname(__FILE__), '..', '..', 'test_helper')

class FFIUtilTest < Test::Unit::TestCase
  context "pointers for type" do
    setup do
      @pointer = mock("pointer")
      FFI::MemoryPointer.stubs(:new).returns(@pointer)
    end

    should "create a standard MemoryPointer for primitives" do
      [:int, :short, :uint, :char].each do |prim|
        FFI::MemoryPointer.expects(:new).with(prim).once.returns(@pointer)
        VirtualBox::FFI::Util.pointer_for_type(prim) {}
      end
    end

    should "create a pointer type for unicode string" do
      FFI::MemoryPointer.expects(:new).with(:pointer).once.returns(@pointer)
      VirtualBox::FFI::Util.pointer_for_type(:unicode_string) do |ptr, type|
        assert_equal :unicode_string, type
      end
    end

    should "create a pointer type for structs" do
      VirtualBox::FFI.expects(:const_get).with(:MyType).returns(true)
      FFI::MemoryPointer.expects(:new).with(:pointer).once.returns(@pointer)
      VirtualBox::FFI::Util.pointer_for_type(:MyType) do |ptr, type|
        assert_equal :struct, type
      end
    end

    should "return the result of the yield" do
      expected = mock("result")
      result = VirtualBox::FFI::Util.pointer_for_type(:int) do |ptr, type|
        expected
      end

      assert_equal expected, result
    end
  end

  context "functionify" do
    should "convert properly" do
      tests = {
        :GetVersion => :get_version,
        :key => :key,
        :testingThisOut => :testing_this_out
      }

      tests.each do |original, result|
        assert_equal result, VirtualBox::FFI::Util.functionify(original)
      end
    end
  end
end