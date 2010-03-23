require File.join(File.dirname(__FILE__), '..', '..', 'test_helper')

class FFIUtilTest < Test::Unit::TestCase
  context "inferring types" do
    should "return the proper values" do
      expectations = {
        :int => [:int, :int],
        :unicode_string => [:pointer, :unicode_string],
        :IHost => [:pointer, :struct]
      }

      expectations.each do |original, result|
        assert_equal result, VirtualBox::FFI::Util.infer_type(original)
      end
    end
  end

  context "pointers for type" do
    setup do
      @pointer = mock("pointer")
      FFI::MemoryPointer.stubs(:new).returns(@pointer)
    end

    should "create a pointer type for the given type" do
      VirtualBox::FFI::Util.expects(:infer_type).with(:MyType).returns([:pointer, :struct])
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

  context "dereferencing pointers" do
    setup do
      @pointer = mock('pointer')
      @pointer.stubs(:respond_to?).returns(true)
      @pointer.stubs(:get_bar).returns("foo")

      @type = :zoo

      @c_type = :foo
      @inferred_type = :bar
      VirtualBox::FFI::Util.stubs(:infer_type).returns([@c_type, @inferred_type])
    end

    should "infer the type" do
      VirtualBox::FFI::Util.expects(:infer_type).with(@type).returns([@c_type, @inferred_type])
      VirtualBox::FFI::Util.dereference_pointer(@pointer, @type)
    end

    should "call get_* method on pointer if it exists" do
      result = mock("result")
      @pointer.expects(:respond_to?).with("get_#{@inferred_type}".to_sym).returns(true)
      @pointer.expects("get_#{@inferred_type}".to_sym).with(0).returns(result)
      assert_equal result, VirtualBox::FFI::Util.dereference_pointer(@pointer, @type)
    end

    should "call read_* on Util if pointer doesn't support it" do
      result = mock("result")
      @pointer.expects(:respond_to?).with("get_#{@inferred_type}".to_sym).returns(false)
      VirtualBox::FFI::Util.expects("read_#{@inferred_type}".to_sym).with(@pointer, @type).returns(result)
      assert_equal result, VirtualBox::FFI::Util.dereference_pointer(@pointer, @type)
    end
  end

  context "functionify" do
    should "convert properly" do
      tests = {
        :GetVersion => :get_version,
        :key => :key,
        :testingThisOut => :testing_this_out,
        :GetAcceleration3DAvailable => :get_acceleration_3davailable
      }

      tests.each do |original, result|
        assert_equal result, VirtualBox::FFI::Util.functionify(original)
      end
    end
  end
end