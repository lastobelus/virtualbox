require File.join(File.dirname(__FILE__), '..', 'test_helper')

class ExtraDataTest < Test::Unit::TestCase
  setup do
    @parent = mock("parent")
    @ed = VirtualBox::ExtraData.new(@parent)
    @ed["foo"] = "bar"
    @ed.clear_dirty!
  end

  context "relationships" do
    setup do
      @caller = mock("caller")
      @caller.stubs(:name).returns("foocaller")
    end

    context "populating" do
      setup do
        @interface = mock("interface")
        @interface.stubs(:get_extra_data_keys).returns([])
      end

      should "return a ExtraData object" do
        result = VirtualBox::ExtraData.populate_relationship(@caller, @interface)
        assert result.is_a?(VirtualBox::ExtraData)
      end

      should "not be dirty" do
        result = VirtualBox::ExtraData.populate_relationship(@caller, @interface)
        assert !result.changed?
      end

      should "add the value of each key to the ED hash" do
        expected_hash = { :a => 1, :b => 2, :c => 4 }
        @interface.expects(:get_extra_data_keys).returns(expected_hash.keys)

        expected_hash.each do |k, v|
          @interface.expects(:get_extra_data).with(k).returns(v)
        end

        result = VirtualBox::ExtraData.populate_relationship(@caller, @interface)
        assert_equal expected_hash.length, result.length
        result.each do |k, v|
          assert_equal expected_hash[k], v
        end
      end
    end

    context "saving" do
      should "call save on the ExtraData object" do
        object = mock("object")
        object.expects(:save).once

        VirtualBox::ExtraData.save_relationship(@caller, object)
      end
    end
  end

  context "setting dirty state" do
    setup do
      @ed = VirtualBox::ExtraData.new(@parent)
    end

    should "not be dirty initially" do
      assert !@ed.changed?
    end

    should "be dirty when setting a value" do
      @ed["foo"] = "bar"
      assert @ed.changed?
      assert @ed.changes.has_key?("foo")
    end
  end

  context "global extra data" do
    setup do
      global = mock("global")
      global.expects(:extra_data).once.returns("foo")
      VirtualBox::Global.expects(:global).returns(global)
      @global = VirtualBox::ExtraData.global(true)
    end

    should "call the global extra data if it has never been loaded" do
      assert_equal "foo", VirtualBox::ExtraData.global
    end

    should "return the same object if it exists for global data, rather than recreating it" do
      VirtualBox::Global.expects(:global).never
      assert_equal @global, VirtualBox::ExtraData.global
    end

    should "return a new object if reload is true" do
      global = mock("global")
      global.expects(:extra_data).once.returns("bar")
      VirtualBox::Global.expects(:global).returns(global)
      assert !@global.equal?(VirtualBox::ExtraData.global(true))
    end
  end

  context "constructor" do
    should "set the parent with the given argument" do
      ed = VirtualBox::ExtraData.new("JOEY")
      assert_equal "JOEY", ed.parent
    end
  end
end