require File.join(File.dirname(__FILE__), '..', '..', 'test_helper')

class AbstractImplementerTest < Test::Unit::TestCase
  setup do
    @klass = VirtualBox::COM::AbstractImplementer
    @interface = mock("interface")
  end

  context "base methods" do
    setup do
      @instance = @klass.new(@interface)
    end

    should "implement the read_property function" do
      assert_nothing_raised {
        @instance.read_property(:foo)
      }
    end

    should "implement the write_property function" do
      assert_nothing_raised {
        @instance.write_property(:foo, :bar)
      }
    end

    should "implement the call_function function" do
      assert_nothing_raised {
        @instance.call_function(:foo, [])
      }
    end
  end
end