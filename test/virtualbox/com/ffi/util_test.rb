require File.join(File.dirname(__FILE__), '..', '..', '..', 'test_helper')

class COMFFIUtilTest < Test::Unit::TestCase
  setup do
    @klass = VirtualBox::COM::FFI::Util
  end

  context "converting function specs to FFI parameter lists" do
    def assert_spec(spec, expected)
      result = @klass.spec_to_ffi(spec)
      result.shift
      assert_equal expected, result
    end

    should "leaving primitives alone" do
      assert_spec([:int], [:int])
    end

    should "convert any out parameters to pointers" do
      assert_spec([[:out, :int]], [:pointer])
    end

    should "convert unicode strings to pointers" do
      assert_spec([:unicode_string], [:pointer])
    end

    should "convert COM interfaces to pointers" do
      assert_spec([:VirtualBox], [:pointer])
    end

    should "add a pointer at the beginning for the `this` parameter" do
      assert_equal [:pointer], @klass.spec_to_ffi([])
    end
  end
end