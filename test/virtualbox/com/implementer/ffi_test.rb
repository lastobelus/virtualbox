require File.join(File.dirname(__FILE__), '..', '..', '..', 'test_helper')

class COMImplementerFFITest < Test::Unit::TestCase
  setup do
    @klass = VirtualBox::COM::Implementer::FFI
  end

  context "initializing" do
    setup do
      @interface = mock("interface")
      @interface.stubs(:class).returns(VirtualBox::COM::Interface::Session)

      @ffi = mock("ffi")

      @pointer = mock("pointer")
    end

    should "initialize the FFI interface associated with the AbstractInterface" do
      result = mock("result")
      VirtualBox::COM::FFI::Session.expects(:new).with(@pointer).once.returns(result)
      instance = @klass.new(@interface, @ffi, @pointer)
      assert_equal result, instance.ffi_interface
    end
  end

  context "with an instance" do
    setup do
      @lib_base = mock("lib_base")
      @ffi_interface = mock("ffi_interface")
      @ffi_class = mock("ffi_class")
      @pointer = mock("pointer")

      @ffi_class.stubs(:new).returns(@ffi_interface)
      @klass.any_instance.stubs(:ffi_class).returns(@ffi_class)

      @instance = @klass.new(@interface, @lib_base, @pointer)
    end

    context "reading a property" do
      should "call call_vtbl_function with the proper arguments" do
        @instance.expects(:call_vtbl_function).with(:get_foo, [[:out, :bar]])
        @instance.read_property(:foo, { :value_type => :bar })
      end
    end

    context "calling a vtbl function" do
      setup do
        @vtbl = mock("vtbl")
        @vtbl_parent = mock("vtbl_parent")
        @ffi_interface.stubs(:vtbl).returns(@vtbl)
        @ffi_interface.stubs(:vtbl_parent).returns(@vtbl_parent)

        @proc = mock("proc")

        @name = :foo
        @spec = [:bar]
        @args = [:baz]
      end

      should "pass in the formal args then return the values from them" do
        result = mock("result")
        @formal = [:foo]

        @instance.expects(:spec_to_args).with(@spec, @args).returns(@formal)
        @vtbl.expects(:[]).with(@name).returns(@proc)
        @proc.expects(:call).with(@vtbl_parent, *@formal)
        @instance.expects(:values_from_formal_args).with(@spec, @formal).returns(result)
        assert_equal result, @instance.call_vtbl_function(@name, @spec, @args)
      end
    end

    context "spec to formal argument list" do
      setup do
        @pointer = mock("pointer")
        @instance.stubs(:pointer_for_type).returns(@pointer)
      end

      should "replace primitives with their types" do
        assert_equal [7], @instance.spec_to_args([:int], [7])
      end

      should "replace single out items with a pointer" do
        @instance.expects(:pointer_for_type).with(:foo).returns(@pointer)
        assert_equal [@pointer], @instance.spec_to_args([[:out, :foo]])
      end
    end

    context "values from a formal parameter list" do
      should "return nil if there are no output parameters" do
        spec = []
        formal = []

        assert_nil @instance.values_from_formal_args(spec, formal)
      end

      should "dereference the pointer with proper type" do
        pointer = mock("pointer")
        spec = [[:out, :foo]]
        formal = [pointer]

        result = mock("result")
        @instance.expects(:dereference_pointer).with(pointer, :foo).once.returns(result)
        assert_equal result, @instance.values_from_formal_args(spec, formal)
      end

      should "return an array for multiple values" do
        spec = [:int, [:out, :foo], [:out, :bar]]
        formal = [1,2,3]

        result = mock("result")
        @instance.stubs(:dereference_pointer).returns(result)
        assert_equal [result, result], @instance.values_from_formal_args(spec, formal)
      end
    end

    context "inferring types" do
      should "return the proper values" do
        expectations = {
          :int => [:int, :int],
          :unicode_string => [:pointer, :unicode_string]
          #:IHost => [:pointer, :struct]
        }

        expectations.each do |original, result|
          assert_equal result, @instance.infer_type(original)
        end
      end
    end

    context "pointers for type" do
      setup do
        @pointer = mock("pointer")
        FFI::MemoryPointer.stubs(:new).returns(@pointer)
      end

      should "create a pointer type for the given type" do
        @instance.expects(:infer_type).with(:MyType).returns([:pointer, :struct])
        FFI::MemoryPointer.expects(:new).with(:pointer).once.returns(@pointer)
        @instance.pointer_for_type(:MyType) do |ptr, type|
          assert_equal :struct, type
        end
      end

      should "return the result of the yield" do
        expected = mock("result")
        result = @instance.pointer_for_type(:int) do |ptr, type|
          expected
        end

        assert_equal expected, result
      end

      should "return the pointer if no block is given" do
        assert_equal @pointer, @instance.pointer_for_type(:int)
      end
    end

    context "dereferencing pointers" do
      setup do
        @pointer = mock('pointer')
        @pointer.stubs(:respond_to?).returns(true)
        @pointer.stubs(:get_bar).returns("foo")

        @type = :zoo

        @c_type = :foo
        @inferred_type = :bar
        @instance.stubs(:infer_type).returns([@c_type, @inferred_type])
      end

      should "infer the type" do
        @instance.expects(:infer_type).with(@type).returns([@c_type, @inferred_type])
        @instance.dereference_pointer(@pointer, @type)
      end

      should "call get_* method on pointer if it exists" do
        result = mock("result")
        @pointer.expects(:respond_to?).with("get_#{@inferred_type}".to_sym).returns(true)
        @pointer.expects("get_#{@inferred_type}".to_sym).with(0).returns(result)
        assert_equal result, @instance.dereference_pointer(@pointer, @type)
      end

      should "return a false bool if type is bool and failure" do
        @pointer.expects(:get_bar).returns(0)
        result = @instance.dereference_pointer(@pointer, VirtualBox::COM::T_BOOL)
        assert_equal false, result
      end

      should "return a true bool if type is bool and success" do
        @pointer.expects(:get_bar).returns(1)
        result = @instance.dereference_pointer(@pointer, VirtualBox::COM::T_BOOL)
        assert_equal true, result
      end

      should "call read_* on Util if pointer doesn't support it" do
        result = mock("result")
        @pointer.expects(:respond_to?).with("get_#{@inferred_type}".to_sym).returns(false)
        @instance.expects("read_#{@inferred_type}".to_sym).with(@pointer, @type).returns(result)
        assert_equal result, @instance.dereference_pointer(@pointer, @type)
      end
    end

    context "custom pointer dereferencers" do
      context "reading unicode string" do
        setup do
          @sub_ptr = mock("sub_ptr")
          @sub_ptr.stubs(:null?).returns(false)

          @ptr = mock("pointer")
          @ptr.stubs(:get_pointer).returns(@sub_ptr)
        end

        should "return empty string for null pointer" do
          @sub_ptr.expects(:null?).returns(true)
          @instance.expects(:utf16_to_string).never
          assert_equal "", @instance.read_unicode_string(@ptr)
        end

        should "call utf16_to_string on the dereferenced pointer" do
          result = mock("result")
          @ptr.expects(:get_pointer).with(0).returns(@sub_ptr)
          @instance.expects(:utf16_to_string).with(@sub_ptr).returns(result)
          assert_equal result, @instance.read_unicode_string(@ptr)
        end
      end
    end
  end
end