require File.join(File.dirname(__FILE__), '..', 'test_helper')

class NetworkAdapterTest < Test::Unit::TestCase
  setup do
    @klass = VirtualBox::NetworkAdapter
    @interface = mock("interface")
    @parent = mock("parent")
  end

  context "initializing" do
    should "load attributes from the machine" do
      @klass.any_instance.expects(:initialize_attributes).with(@parent, @interface).once
      @klass.new(@parent, @interface)
    end
  end

  context "initializing attributes" do
    setup do
      @klass.any_instance.stubs(:load_interface_attributes)
      @klass.any_instance.stubs(:populate_relationships)
    end

    should "load interface attribtues" do
      @klass.any_instance.expects(:load_interface_attributes).with(@interface).once
      @klass.new(@parent, @interface)
    end

    should "setup the parent" do
      instance = @klass.new(@parent, @interface)
      assert_equal @parent, instance.parent
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

  context "class methods" do
    context "populating relationship" do
      setup do
        @instance = mock("instance")
        @klass.stubs(:new).returns(@instance)

        @count = 5
        @vbox = mock("vbox")
        @system_properties = mock("sys_props")
        @interface.stubs(:get_parent).returns(@vbox)
        @vbox.stubs(:get_system_properties).returns(@system_properties)
        @system_properties.stubs(:get_network_adapter_count).returns(@count)
      end

      should "return a proxied collection" do
        @system_properties.stubs(:get_network_adapter_count).returns(0)
        result = @klass.populate_relationship(nil, @interface)
        assert result.is_a?(VirtualBox::Proxies::Collection)
      end

      should "call new for every shared folder" do
        expected_result = []
        new_seq = sequence("new_seq")
        @count.times do |i|
          expected_value = "instance-#{i}"
          adapter = mock("adapter#{i}")
          @interface.expects(:get_network_adapter).with(i).returns(adapter).in_sequence(new_seq)
          @klass.expects(:new).with(@parent, adapter).in_sequence(new_seq).returns(expected_value)
          expected_result << expected_value
        end

        assert_equal expected_result, @klass.populate_relationship(@parent, @interface)
      end
    end
  end
end