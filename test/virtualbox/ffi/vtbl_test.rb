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
      should "add to layout args then define method" do
        member_seq = sequence("member")
        @layout_args.expects(:<<).with([:key, :key]).once.in_sequence(member_seq)
        VirtualBox::FFI::VTbl.expects(:define_method).with(:key).once.in_sequence(member_seq)
        VirtualBox::FFI::VTbl.member_getter(:key, :foo)
      end

      context "the defined method" do
        class FooStruct < VirtualBox::FFI::VTbl
          define_layout do
            member :int, :getter, :string
          end
        end

        setup do
          @name = :int
          @type = :string

          @parent = mock("parent")
          @struct = FooStruct.new(@parent)

          @proc = mock("proc")
          @proc.stubs(:call)
          @struct.stubs(:[]).with(@name).returns(@proc)

          @ptr = mock("pointer")
          @ptr.stubs(:respond_to?).returns(true)
          @ptr.stubs(:read_string)
          FFI::MemoryPointer.stubs(:new).returns(@ptr)
        end

        should "respond to the getter method" do
          assert @struct.respond_to?(@name)
        end

        should "call the method with a pointer" do
          @proc.expects(:call).with(@parent, @ptr).once
          @struct.send(@name)
        end

        should "call the read_* method on the pointer if it responds and return its value" do
          result = mock('result')
          @ptr.expects(:respond_to?).with("read_#{@type}".to_sym).once.returns(true)
          @ptr.expects("read_#{@type}".to_sym).once.returns(result)
          assert_equal result, @struct.send(@name)
        end

        should "call the read_* method on the struct itself otherwise and return its value" do
          result = mock('result')
          @ptr.expects(:respond_to?).returns(false)
          @struct.expects("read_#{@type}".to_sym).with(@ptr).once.returns(result)
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

    context "reading unicode string" do
      setup do
        @sub_ptr = mock("subptr")
        @ptr = mock("ptr")
        @ptr.stubs(:get_pointer).returns(@sub_ptr)

        @function = mock("function")
        @function.stubs(:call)

        @xpcom = mock("xpcom")
        @xpcom.stubs(:[]).returns(@function)
        @struct.stubs(:xpcom).returns(@xpcom)
      end

      should "convert to UTF8 then return the result" do
        result = "foo"
        convert_seq = sequence("convert")
        @xpcom.expects(:[]).with(:pfnUtf16ToUtf8).returns(@function).in_sequence(convert_seq)
        @function.expects(:call).with(@sub_ptr, @ptr).once.in_sequence(convert_seq)
        @ptr.expects(:read_pointer).returns(@sub_ptr).in_sequence(convert_seq)
        @sub_ptr.expects(:read_string).returns(result).in_sequence(convert_seq)
        assert_equal result, @struct.read_unicode_string(@ptr)
      end
    end
  end
end