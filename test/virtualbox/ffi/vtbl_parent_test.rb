require File.join(File.dirname(__FILE__), '..', '..', 'test_helper')

class FFIVTblParentTest < Test::Unit::TestCase
  setup do
    @vtbl_parent = VirtualBox::FFI::VTblParent
  end

  context "setting the parent of" do
    context "calling the class method" do
      setup do
        @vtbl_parent.stubs(:layout)
        @vtbl_parent.stubs(:define_method)
      end

      should "call layout and set the vtbl member" do
        @vtbl_parent.expects(:layout).with(:vtbl, :pointer).once
        @vtbl_parent.parent_of(:foo)
      end

      should "define a new vtbl method" do
        @vtbl_parent.expects(:define_method).with(:vtbl).once
        @vtbl_parent.parent_of(:foo)
      end
    end

    context "the defined method" do
      class ParentOfMethodStruct < VirtualBox::FFI::VTblParent
        parent_of :foo
      end

      setup do
        @klass_name = :foo
        @klass = mock("class")

        @vtbl = mock("vtbl")

        @instance = ParentOfMethodStruct.new
        @instance.stubs(:[]).with(:vtbl).returns(@vtbl)

        VirtualBox::FFI.stubs(:const_get).with(@klass_name).returns(@klass)
        @klass.stubs(:new).with(@instance, @instance[:vtbl]).returns(@vtbl)
      end

      should "initialize the vtbl class" do
        VirtualBox::FFI.expects(:const_get).with(@klass_name).returns(@klass)
        @klass.expects(:new).with(@instance, @instance[:vtbl]).returns(@vtbl)
        assert_equal @vtbl, @instance.vtbl
      end

      should "only initialize the class once" do
        @klass.expects(:new).once.returns(@vtbl)
        assert_equal @vtbl, @instance.vtbl
        assert_equal @vtbl, @instance.vtbl
        assert_equal @vtbl, @instance.vtbl
      end
    end
  end

  context "forwarding to the vtbl" do
    class ForwardingMethodVtblParent < VirtualBox::FFI::VTblParent
      parent_of :foo
    end

    setup do
      @vtbl = mock("vtbl")

      @instance = ForwardingMethodVtblParent.new
      @instance.stubs(:vtbl).returns(@vtbl)
    end

    should "forward non-existent methods to the vtbl" do
      method = :foo_bar_baz
      args = [1,2,3]
      assert !@instance.respond_to?(method) # sanity
      @vtbl.expects(method).with(*args).once
      @instance.send(method, *args)
    end
  end
end