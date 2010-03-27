require File.join(File.dirname(__FILE__), '..', 'test_helper')

class MediumTest < Test::Unit::TestCase
  setup do
    @klass = VirtualBox::Medium
    @imedium = mock("IMedium")
  end

  context "initializing" do
    should "load attributes from the medium" do
      @klass.any_instance.expects(:load_attributes).with(@imedium).once
      @klass.new(@imedium)
    end
  end

  context "loading attributes" do
    should "populate attributes with values of sending to IMedium" do
      expected_value = "foo"
      @imedium.expects(:send).with(anything).at_least(0).returns(expected_value)
      @klass.any_instance.expects(:populate_attributes).with() do |hash|
        hash.each do |key, value|
          assert_equal expected_value, value
        end

        true
      end

      @klass.new(@imedium)
    end
  end

  context "with an instance" do
    setup do
      @klass.any_instance.stubs(:load_attributes)
      @instance = @klass.new(@imedium)
    end

    context "filename" do
      setup do
        @location = "/foo/bar/baz.rb"
        @instance.stubs(:location).returns(@location)
      end

      should "return the basename of the location" do
        assert_equal File.basename(@location), @instance.filename
      end
    end
  end
end