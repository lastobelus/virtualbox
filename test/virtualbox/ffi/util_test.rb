require File.join(File.dirname(__FILE__), '..', '..', 'test_helper')

class FFIUtilTest < Test::Unit::TestCase
  context "inferring types" do
    should "return the proper values" do
      expectations = {
        :int => [:int, :int],
        :unicode_string => [:pointer, :unicode_string],
        :IHost => [:pointer, :struct]
      }

      expectations.each do |original, result|
        assert_equal result, VirtualBox::FFI::Util.infer_type(original)
      end
    end
  end

  context "pointers for type" do
    setup do
      @pointer = mock("pointer")
      FFI::MemoryPointer.stubs(:new).returns(@pointer)
    end

    should "create a pointer type for the given type" do
      VirtualBox::FFI::Util.expects(:infer_type).with(:MyType).returns([:pointer, :struct])
      FFI::MemoryPointer.expects(:new).with(:pointer).once.returns(@pointer)
      VirtualBox::FFI::Util.pointer_for_type(:MyType) do |ptr, type|
        assert_equal :struct, type
      end
    end

    should "return the result of the yield" do
      expected = mock("result")
      result = VirtualBox::FFI::Util.pointer_for_type(:int) do |ptr, type|
        expected
      end

      assert_equal expected, result
    end

    should "return the pointer and type if no block is given" do
      assert_equal [@pointer, :int], VirtualBox::FFI::Util.pointer_for_type(:int)
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
      VirtualBox::FFI::Util.stubs(:infer_type).returns([@c_type, @inferred_type])
    end

    should "infer the type" do
      VirtualBox::FFI::Util.expects(:infer_type).with(@type).returns([@c_type, @inferred_type])
      VirtualBox::FFI::Util.dereference_pointer(@pointer, @type)
    end

    should "call get_* method on pointer if it exists" do
      result = mock("result")
      @pointer.expects(:respond_to?).with("get_#{@inferred_type}".to_sym).returns(true)
      @pointer.expects("get_#{@inferred_type}".to_sym).with(0).returns(result)
      assert_equal result, VirtualBox::FFI::Util.dereference_pointer(@pointer, @type)
    end

    should "call read_* on Util if pointer doesn't support it" do
      result = mock("result")
      @pointer.expects(:respond_to?).with("get_#{@inferred_type}".to_sym).returns(false)
      VirtualBox::FFI::Util.expects("read_#{@inferred_type}".to_sym).with(@pointer, @type).returns(result)
      assert_equal result, VirtualBox::FFI::Util.dereference_pointer(@pointer, @type)
    end
  end

  context "dereferencing pointer array" do
    setup do
      @array_pointer = mock('array_pointer')
      @array_pointer.stubs(:respond_to?).returns(true)
      @array_pointer.stubs(:get_array_of_bar)

      @pointer = mock('pointer')
      @pointer.stubs(:get_pointer).with(0).returns(@array_pointer)

      @type = :zoo
      @length = 3

      @c_type = :foo
      @inferred_type = :bar
      VirtualBox::FFI::Util.stubs(:infer_type).returns([@c_type, @inferred_type])
    end

    should "infer the type" do
      VirtualBox::FFI::Util.expects(:infer_type).with(@type).returns([@c_type, @inferred_type])
      VirtualBox::FFI::Util.dereference_pointer_array(@pointer, @type, @length)
    end

    should "call get_* method on array pointer if it exists" do
      result = mock("result")
      @array_pointer.expects(:respond_to?).with("get_array_of_#{@inferred_type}".to_sym).returns(true)
      @array_pointer.expects("get_array_of_#{@inferred_type}".to_sym).with(0, @length).returns(result)
      assert_equal result, VirtualBox::FFI::Util.dereference_pointer_array(@pointer, @type, @length)
    end

    should "call read_* on Util if pointer doesn't support it" do
      result = mock("result")
      @array_pointer.expects(:respond_to?).with("get_array_of_#{@inferred_type}".to_sym).returns(false)
      VirtualBox::FFI::Util.expects("read_array_of_#{@inferred_type}".to_sym).with(@array_pointer, @type, @length).returns(result)
      assert_equal result, VirtualBox::FFI::Util.dereference_pointer_array(@pointer, @type, @length)
    end
  end

  context "functionify" do
    should "convert properly" do
      tests = {
        :GetVersion => :get_version,
        :key => :key,
        :testingThisOut => :testing_this_out,
        :GetAcceleration3DAvailable => :get_acceleration_3davailable
      }

      tests.each do |original, result|
        assert_equal result, VirtualBox::FFI::Util.functionify(original)
      end
    end
  end

  context "custom pointer dereferencers" do
    context "reading unicode string" do
      setup do
        @sub_ptr = mock("subptr")
        @ptr = mock("ptr")
        @ptr.stubs(:get_pointer).returns(@sub_ptr)

        @function = mock("function")
        @function.stubs(:call)

        @xpcom = mock("xpcom")
        @xpcom.stubs(:[]).returns(@function)
        VirtualBox::Lib.stubs(:xpcom).returns(@xpcom)

        @original_type = :foo
      end

      should "convert to UTF8 then return the result" do
        result = "foo"
        convert_seq = sequence("convert")
        @xpcom.expects(:[]).with(:pfnUtf16ToUtf8).returns(@function).in_sequence(convert_seq)
        @function.expects(:call).with(@sub_ptr, @ptr).once.in_sequence(convert_seq)
        @ptr.expects(:read_pointer).returns(@sub_ptr).in_sequence(convert_seq)
        @sub_ptr.expects(:read_string).returns(result).in_sequence(convert_seq)
        assert_equal result, VirtualBox::FFI::Util.read_unicode_string(@ptr, @original_type)
      end
    end

    context "reading struct" do
      setup do
        @original_type = :foo
        @klass = mock("foo_class")

        @sub_ptr = mock("sub_ptr")
        @ptr = mock("pointer")
        @ptr.stubs(:get_pointer).with(0).returns(@sub_ptr)
      end

      should "convert type to a const and return instance" do
        VirtualBox::FFI.expects(:const_get).with(@original_type).returns(@klass)
        @klass.expects(:new).with(@ptr.get_pointer(0)).returns(@instance)
        assert_equal @instance, VirtualBox::FFI::Util.read_struct(@ptr, @original_type)
      end
    end

    context "reading an array of structs" do
      setup do
        @type = :foo
        @length = 3

        @pointers = []
        @length.times do |i|
          pointer = mock("pointer#{i}")
          @pointers << pointer
        end

        @pointer = mock("pointer")
        @pointer.stubs(:get_array_of_pointer).returns(@pointers)

        @klass = mock("foo_class")

        VirtualBox::FFI::Util.stubs(:read_struct).returns("foo")
      end

      should "grab the array of pointers, then convert each to a struct" do
        deref_seq = sequence("deref_seq")
        VirtualBox::FFI.expects(:const_get).with(@type).returns(@klass)
        @pointer.expects(:get_array_of_pointer).with(0, @length).returns(@pointers).in_sequence(deref_seq)
        return_values = @pointers.collect do |pointer|
          value = "struct_of_pointer: #{pointer}"
          @klass.expects(:new).with(pointer).returns(value).in_sequence(deref_seq)
          value
        end

        assert_equal return_values, VirtualBox::FFI::Util.read_array_of_struct(@pointer, @type, @length)
      end
    end
  end
end