require File.join(File.dirname(__FILE__), '..', 'test_helper')

class VMTest < Test::Unit::TestCase
  setup do
    @klass = VirtualBox::VM
    @interface = mock("interface")
  end

  context "class methods" do
    context "retrieving all machines" do
      should "return an array of VM objects" do
        vms = mock("vms")
        global = mock("global")
        global.expects(:vms).returns(vms)
        VirtualBox::Global.expects(:global).returns(global)
        assert_equal vms, VirtualBox::VM.all
      end
    end

    context "finding a VM" do
      setup do
        @all = []
        @klass.stubs(:all).returns(@all)
      end

      def mock_vm(uuid, name=nil)
        vm = mock("vm-#{uuid}")
        vm.stubs(:uuid).returns(uuid)
        vm.stubs(:name).returns(name)
        vm
      end

      should "return nil if it doesn't exist" do
        @all << mock_vm("foo")
        assert_nil @klass.find("bar")
      end

      should "return the matching vm if it is found" do
        vm = mock_vm("foo")
        @all << mock_vm("bar")
        @all << vm
        assert_equal vm, @klass.find("foo")
      end

      should "return if matching name is found" do
        vm = mock_vm(nil, "foo")
        @all << vm
        assert_equal vm, @klass.find("foo")
      end
    end

    context "populating relationship" do
      setup do
        @instance = mock("instance")

        @klass.stubs(:new).returns(@instance)
      end

      should "return a proxied collection" do
        result = @klass.populate_relationship(nil, [])
        assert result.is_a?(VirtualBox::Proxies::Collection)
      end

      should "call new for every machine" do
        machines = []
        5.times { |i| machines << mock("m#{i}") }

        expected_result = []
        new_seq = sequence("new_seq")
        machines.each do |machine|
          expected_value = "instance-#{machine.inspect}"
          @klass.expects(:new).with(machine).in_sequence(new_seq).returns(expected_value)
          expected_result << expected_value
        end

        assert_equal expected_result, @klass.populate_relationship(nil, machines)
      end
    end
  end

  context "initializing" do
    should "load attributes from the machine" do
      @klass.any_instance.expects(:initialize_attributes).with(@interface).once
      @klass.new(@interface)
    end
  end

  context "initializing attributes" do
    setup do
      @klass.any_instance.stubs(:load_interface_attributes)
    end

    should "load interface attribtues" do
      @klass.any_instance.expects(:load_interface_attributes).with(@interface).once
      @klass.new(@interface)
    end

    should "not be dirty" do
      @instance = @klass.new(@interface)
      assert !@instance.changed?
    end

    should "be existing record" do
      @instance = @klass.new(@interface)
      assert !@instance.new_record?
    end
  end
end