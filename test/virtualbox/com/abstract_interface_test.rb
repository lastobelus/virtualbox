require File.join(File.dirname(__FILE__), '..', '..', 'test_helper')

class AbstractInterfaceTest < Test::Unit::TestCase
  class EmptyAITest < VirtualBox::COM::AbstractInterface
  end

  class BasicAITest < EmptyAITest
    function :foo, []
    function :foo2, []
    property :bar, :int
    property :bar2, :int
    property :bar3, :int
  end

  context "class methods" do
    context "without any members defined" do
      setup do
        @klass = EmptyAITest
        @klass.members.clear

        @klass.stubs(:define_method)
      end

      should "put defined functions in the members hash" do
        assert_nil @klass.member(:foo)
        @klass.function(:foo, :bar)
        assert @klass.member(:foo)
      end

      should "define an method for functions" do
        @klass.expects(:define_method).with(:foo)
        @klass.function(:foo, :bar)
      end

      should "put defined properties in the members hash" do
        assert_nil @klass.member(:foo)
        @klass.property(:foo, :bar)
        assert @klass.member(:foo)
      end

      should "create methods for reading and writing properties" do
        @klass.expects(:define_method).with(:foo).once
        @klass.expects(:define_method).with(:foo=).once
        @klass.property(:foo, :bar)
      end

      should "not creating writing method for property if its readonly" do
        @klass.expects(:define_method).with(:foo=).never
        @klass.property(:foo, :bar, :readonly => true)
      end
    end

    context "with members defined" do
      setup do
        @klass = BasicAITest
      end

      should "return the properties in order" do
        properties = @klass.properties
        properties.collect! { |prop| prop[0] }

        assert_equal [:bar, :bar2, :bar3], properties
      end

      should "return the functions in order" do
        funcs = @klass.functions
        funcs.collect! { |func| func[0] }

        assert_equal [:foo, :foo2], funcs
      end
    end
  end

  context "instance methods" do
    setup do
      @interface = BasicAITest.new
    end

    context "checking for property existence" do
      should "return true for existing properties" do
        assert @interface.has_property?(:bar)
      end

      should "return false non-existent properties and methods" do
        assert !@interface.has_property?(:foo)
      end
    end

    context "checking for function existence" do
      should "return true for existing functions" do
        assert @interface.has_function?(:foo)
      end

      should "return false non-existent function and properties" do
        assert !@interface.has_function?(:bar)
      end
    end
  end
end