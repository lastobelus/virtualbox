require File.join(File.dirname(__FILE__), '..', '..', 'test_helper')

class AbstractInterfaceTest < Test::Unit::TestCase
  context "class methods" do
    class ClassMethodAITest < VirtualBox::COM::AbstractInterface
    end

    setup do
      @klass = ClassMethodAITest
      @klass.members.clear

      @klass.stubs(:define_method)
    end

    should "put defined functions in the members hash" do
      assert_nil @klass.members[:foo]
      @klass.function(:foo, :bar)
      assert @klass.members[:foo]
    end

    should "define an method for functions" do
      @klass.expects(:define_method).with(:foo)
      @klass.function(:foo, :bar)
    end

    should "put defined properties in the members hash" do
      assert_nil @klass.members[:foo]
      @klass.property(:foo, :bar)
      assert @klass.members[:foo]
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

  context "instance methods" do
    class EmptyAITest < VirtualBox::COM::AbstractInterface
    end

    class BasicAITest < EmptyAITest
      function :foo, []
      property :bar, :int
    end

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
  end
end