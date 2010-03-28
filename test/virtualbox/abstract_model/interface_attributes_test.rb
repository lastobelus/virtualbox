require File.join(File.dirname(__FILE__), '..', '..', 'test_helper')

class InterfaceAttributesTest < Test::Unit::TestCase
  class EmptyInterfaceAttributeModel
    include VirtualBox::AbstractModel::Attributable
    include VirtualBox::AbstractModel::InterfaceAttributes
  end

  class InterfaceAttributeModel < EmptyInterfaceAttributeModel
    attribute :foo, :interface_getter => :foo
    attribute :bar
  end

  context "converting spec to a proc" do
    setup do
      @instance = EmptyInterfaceAttributeModel.new
      @interface = mock("interface")
    end

    context "symbols" do
      should "convert to a proc which calls the symbol on the interface" do
        result = mock("result")
        proc = @instance.spec_to_proc(:foo)
        @interface.expects(:foo).once.returns(result)
        assert_equal result, proc.call(@interface)
      end
    end

    context "procs" do
      should "leave proc as is" do
        result = mock("result")
        proc = Proc.new { |m| result }
        converted = @instance.spec_to_proc(proc)
        assert_equal proc, converted
        assert_equal result, converted.call(@interface)
      end
    end
  end

  context "loading a single interface attribute" do
    setup do
      @instance = InterfaceAttributeModel.new
      @interface = mock("interface")
      @interface.stubs(:foo).returns("foo")

      @proc = Proc.new { |m| m.foo }
      @instance.stubs(:spec_to_proc).returns(@proc)
    end

    should "return immediately if not a valid attribute" do
      @proc.expects(:call).never
      @instance.load_interface_attribute(:baz, @interface)
    end

    should "return immediately if attribute doesn't have an interface getter" do
      @proc.expects(:call).never
      @instance.load_interface_attribute(:bar, @interface)
    end

    should "write the attribute with the value of the proc" do
      key = :foo
      @instance.expects(:write_attribute).with(key, "foo").once
      @instance.load_interface_attribute(key, @interface)
    end
  end

  context "loading all interface attributes" do
    setup do
      @instance = InterfaceAttributeModel.new
      @interface = mock('interface')
    end

    should "load each" do
      load_seq = sequence("load_seq")
      InterfaceAttributeModel.attributes.each do |key, options|
        @instance.expects(:load_interface_attribute).with(key, @interface)
      end

      @instance.load_interface_attributes(@interface)
    end
  end
end