require File.join(File.dirname(__FILE__), '..', 'test_helper')

class StorageControllerTest < Test::Unit::TestCase
  setup do
    @interface = mock("interface")
    @parent = mock("parent")

    @klass = VirtualBox::StorageController
  end

  context "class methods" do
    context "populating relationships" do
      setup do
        @instance = mock("instance")

        @interface.stubs(:get_storage_controllers).returns([])

        @klass.stubs(:device_type).returns(:all)
        @klass.stubs(:new).returns(@instance)
      end

      def mock_controller(name)
        controller = mock(name)
        controller
      end

      should "return a proxied collection" do
        result = @klass.populate_relationship(nil, @interface)
        assert result.is_a?(VirtualBox::Proxies::Collection)
      end

      should "call new for every medium if device type is all" do
        controllers = []
        @interface.stubs(:get_storage_controllers).returns(controllers)
        5.times { |i| controllers << mock_controller("c#{i}") }

        expected_result = []
        new_seq = sequence("new_seq")
        controllers.each do |controller|
          expected_value = "instance-#{controller.inspect}"
          @klass.expects(:new).with(@parent, controller).in_sequence(new_seq).returns(expected_value)
          expected_result << expected_value
        end

        assert_equal expected_result, @klass.populate_relationship(@parent, @interface)
      end
    end
  end

  context "initializing" do
    setup do
      @klass.any_instance.stubs(:load_interface_attributes)
    end

    should "load interface attribtues" do
      @klass.any_instance.expects(:load_interface_attributes).with(@interface).once
      @klass.new(@parent, @interface)
    end

    should "not be dirty" do
      @instance = @klass.new(@parent, @interface)
      assert !@instance.changed?
    end

    should "be existing record" do
      @instance = @klass.new(@parent, @interface)
      assert !@instance.new_record?
    end
  end

  context "instance methods" do
    setup do
      @klass.any_instance.stubs(:load_interface_attributes)

      @parent = mock("parent")
      @interface = mock("interface")
      @instance = @klass.new(@parent, @interface)
    end

    # None yet
  end
end