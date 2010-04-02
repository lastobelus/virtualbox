require File.join(File.dirname(__FILE__), '..', '..', 'test_helper')

class COMAbstractEnumTest < Test::Unit::TestCase
  context "setting up the map" do
    setup do
      @enum = VirtualBox::COM::AbstractEnum
      @enum.reset!
    end

    should "set the map up and be able to access it" do
      @enum.map([:a, :b, :c])
      assert_equal :a, @enum[0]
      assert_equal :b, @enum[1]
      assert_equal :c, @enum[2]
    end

    should "do the reverse mapping of value to index" do
      @enum.map([:a, :b, :c])
      assert_equal 1, @enum.index(:b)
    end

    should "reset the map if another is given" do
      @enum.map([:a])
      @enum.map([:b])
      assert_equal :b, @enum[0]
    end
  end
end