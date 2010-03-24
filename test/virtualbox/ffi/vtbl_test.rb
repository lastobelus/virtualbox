require File.join(File.dirname(__FILE__), '..', '..', 'test_helper')

class FFIVTblTest < Test::Unit::TestCase
  context "defining a layout" do
    setup do
      @layout_args = []
      VirtualBox::FFI::VTbl.stubs(:layout_args).returns(@layout_args)
    end

    should "clear the layout args prior to yielding, then commit" do
      define_sequence = sequence("define_sequence")
      @layout_args.expects(:clear).in_sequence(define_sequence)
      @layout_args.expects(:<<).in_sequence(define_sequence)
      VirtualBox::FFI::VTbl.expects(:layout).with(*@layout_args.flatten).in_sequence(define_sequence)
      VirtualBox::FFI::VTbl.define_layout do
        layout_args << "FOO"
      end
    end
  end

  context "with opts" do
    class WithOptsTestClass < VirtualBox::FFI::VTbl
      class <<self
        # Accessor for inspection during testing
        def scoped_opts
          @@_scoped_opts
        end
      end
    end

    setup do
      @klass = WithOptsTestClass
    end

    should "setup the scoped opts to the given value" do
      # Since the block is evaled in another context, we have to use
      # exceptions to do testing
      assert_nothing_raised {
        @klass.with_opts(:foo => :bar) do
          raise Exception.new if :bar != scoped_opts[:foo]
        end
      }
    end

    should "reset the scoped opts after running" do
      @klass.with_opts(:foo => :bar) {}
      assert @klass.scoped_opts.empty?
    end

    should "allow nested scoped opts" do
      assert_nothing_raised {
        @klass.with_opts(:foo => :bar, :bar => :foo) do
          with_opts(:foo => :baz) do
            raise Exception.new("foo incorrect") unless scoped_opts[:foo] == :baz
            raise Exception.new("bar incorrect") unless scoped_opts[:bar] == :foo
          end

          raise Exception.new("foo was not reset") unless scoped_opts[:foo] == :bar
        end
      }
    end
  end

  context "members" do
    setup do
      @layout_args = []
      VirtualBox::FFI::VTbl.stubs(:layout_args).returns(@layout_args)
    end

    context "adding members" do
      should "just add to the layout_args array if a typical type" do
        @layout_args.expects(:<<).with([:key, :int]).once
        VirtualBox::FFI::VTbl.member(:key, :int)
      end

      should "call the special function if a special type is given" do
        VirtualBox::FFI::VTbl.expects(:member_getter).once.with(:key, 1,2,3)
        VirtualBox::FFI::VTbl.member(:key, :getter, 1,2,3)
      end
    end

    context "getter member" do
      def test_layout_args_with_type(expected_type, opts = {})
        member_seq = sequence("member")
        @layout_args.expects(:<<).with([:key, expected_type]).once.in_sequence(member_seq)
        VirtualBox::FFI::VTbl.expects(:define_method).with(:key).once.in_sequence(member_seq)
        VirtualBox::FFI::VTbl.member_getter(:key, :foo, opts)
      end

      should "add to layout args then define method" do
        test_layout_args_with_type(:key)
      end

      should "use custom function type if given" do
        test_layout_args_with_type(:custom_type, :function_type => :custom_type)
      end

      should "use scoped opts if given" do
        VirtualBox::FFI::VTbl.stubs(:scoped_opts).returns(:function_type => :scoped_type)
        test_layout_args_with_type(:scoped_type)
      end

      context "the defined method" do
        class GetterFooStruct < VirtualBox::FFI::VTbl
          define_layout do
            member :int, :getter, :string
          end
        end

        setup do
          @name = :int
          @type = :string

          @parent = mock("parent")
          @struct = GetterFooStruct.new(@parent)

          @proc = mock("proc")
          @proc.stubs(:call)
          @struct.stubs(:[]).with(@name).returns(@proc)

          @ptr = mock("pointer")
          @ptr.stubs(:respond_to?).returns(true)
          @ptr.stubs(:get_string).returns('foo')

          VirtualBox::FFI::Util.stubs(:pointer_for_type).yields(@ptr, @type)
        end

        should "respond to the getter method" do
          assert @struct.respond_to?(@name)
        end

        should "call the Util.pointer_for_type method" do
          VirtualBox::FFI::Util.expects(:pointer_for_type).with(@type).once
          @struct.send(@name)
        end

        should "call the proc with the given pointer and parent" do
          @proc.expects(:call).with(@parent, @ptr).once
          @struct.send(@name)
        end

        should "return the result of dereferencing the pointer" do
          deref_seq = sequence("deref_seq")
          @proc.expects(:call).with(@parent, @ptr).once.in_sequence(deref_seq)
          VirtualBox::FFI::Util.expects(:dereference_pointer).with(@ptr, @type).once.in_sequence(deref_seq)
          @struct.send(@name)
        end
      end
    end

    context "array getter member" do
      def test_array_layout_args_with_type(expected_type, opts = {})
        member_seq = sequence("member")
        @layout_args.expects(:<<).with([:key, expected_type]).once.in_sequence(member_seq)
        VirtualBox::FFI::VTbl.expects(:define_method).with(:key).once.in_sequence(member_seq)
        VirtualBox::FFI::VTbl.member_array_getter(:key, :foo, opts)
      end

      should "add to layout args then define method" do
        test_array_layout_args_with_type(:key)
      end

      should "use custom function type if given" do
        test_array_layout_args_with_type(:custom_type, :function_type => :custom_type)
      end

      should "use scoped opts if given" do
        VirtualBox::FFI::VTbl.stubs(:scoped_opts).returns(:function_type => :scoped_type)
        test_array_layout_args_with_type(:scoped_type)
      end

      context "the defined method" do
        class ArrayGetterFooStruct < VirtualBox::FFI::VTbl
          define_layout do
            member :int, :array_getter, :string
          end
        end

        setup do
          @name = :int
          @type = :string
          @count_type = VirtualBox::FFI::PRUint32

          @parent = mock("parent")
          @struct = ArrayGetterFooStruct.new(@parent)

          @proc = mock("proc")
          @proc.stubs(:call)
          @struct.stubs(:[]).with(@name).returns(@proc)

          @ptr = mock("pointer")
          @ptr.stubs(:respond_to?).returns(true)
          @ptr.stubs(:get_string).returns('foo')

          @count_ptr = mock("count_pointer")

          VirtualBox::FFI::Util.stubs(:pointer_for_type).with(@type).returns([@ptr, @type])
          VirtualBox::FFI::Util.stubs(:pointer_for_type).with(@count_type).returns([@count_ptr, @count_type])

          VirtualBox::FFI::Util.stubs(:dereference_pointer).returns('foo')
          VirtualBox::FFI::Util.stubs(:dereference_pointer_array).returns('foo')
        end

        should "respond to the getter method" do
          assert @struct.respond_to?(@name)
        end

        should "call the proc with the proper pointer types" do
          @proc.expects(:call).with(@parent, @count_ptr, @ptr)
          @struct.send(@name)
        end

        should "dereference the array with the dereferenced count" do
          count = 7
          result = mock("result")
          VirtualBox::FFI::Util.expects(:dereference_pointer).with(@count_ptr, @count_type).returns(count)
          VirtualBox::FFI::Util.expects(:dereference_pointer_array).with(@ptr, @type, count).returns(result)
          assert_equal result, @struct.send(@name)
        end
      end
    end
  end

  context "instance" do
    class FooStruct < VirtualBox::FFI::VTbl
      define_layout do
        member :foo, :int
      end
    end

    setup do
      @parent = mock("parent")
      @struct = FooStruct.new(@parent)
    end

    context "initializing" do
      should "set the parent" do
        parent = mock("parent")
        vtbl = FooStruct.new(parent)
        assert_equal parent, vtbl.parent
      end
    end

    context "xpcom instance" do
      should "return the value from VirtualBox::Lib" do
        xpcom = mock("xpcom")
        VirtualBox::Lib.expects(:xpcom).returns(xpcom)
        assert_equal xpcom, @struct.xpcom
      end
    end
  end
end