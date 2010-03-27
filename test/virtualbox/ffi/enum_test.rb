require File.join(File.dirname(__FILE__), '..', '..', 'test_helper')

class FFIEnumTest < Test::Unit::TestCase
  context "setting up the map" do
    setup do
      @enum = VirtualBox::FFI::Enum
      @enum.reset!
    end

    should "set the map up and be able to access it" do
      @enum.map([:a, :b, :c])
      assert_equal :a, @enum[0]
      assert_equal :b, @enum[1]
      assert_equal :c, @enum[2]
    end

    should "reset the map if another is given" do
      @enum.map([:a])
      @enum.map([:b])
      assert_equal :b, @enum[0]
    end
  end
end