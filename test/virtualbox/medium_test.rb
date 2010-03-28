require File.join(File.dirname(__FILE__), '..', 'test_helper')

class MediumTest < Test::Unit::TestCase
  setup do
    @klass = VirtualBox::Medium
    @imedium = mock("IMedium")
  end

  context "class methods" do
    context "device type" do
      should "be all on the medium" do
        assert_equal :all, @klass.device_type
      end
    end

    context "populating relationship" do
      setup do
        @instance = mock("instance")

        @klass.stubs(:device_type).returns(:all)
        @klass.stubs(:new).returns(@instance)
      end

      def mock_medium(device_type)
        medium = mock("medium")
        medium.stubs(:get_device_type).returns(device_type)
        medium
      end

      should "return a proxied collection" do
        result = @klass.populate_relationship(nil, [])
        assert result.is_a?(VirtualBox::Proxies::Collection)
      end

      should "call new for every medium if device type is all" do
        media = []
        5.times { |i| media << mock_medium("m#{i}") }

        expected_result = []
        new_seq = sequence("new_seq")
        media.each do |medium|
          expected_value = "instance-#{medium.inspect}"
          @klass.expects(:new).with(medium).in_sequence(new_seq).returns(expected_value)
          expected_result << expected_value
        end

        assert_equal expected_result, @klass.populate_relationship(nil, media)
      end

      should "ignore non-matching devices if device_type is not :all" do
        @klass.stubs(:device_type).returns(:foo)

        media = [mock_medium(:foo), mock_medium(:bar)]
        result = @klass.populate_relationship(nil, media)
        assert_equal 1, result.length
      end
    end
  end

  context "initializing" do
    should "load attributes from the medium" do
      @klass.any_instance.expects(:load_interface_attributes).with(@imedium).once
      @klass.new(@imedium)
    end
  end

  context "with an instance" do
    setup do
      @klass.any_instance.stubs(:load_interface_attributes)
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