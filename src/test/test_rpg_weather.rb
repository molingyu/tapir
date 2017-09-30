module RGSSTest
  class TestRPGWeather
    include RGSSTest

    @@klass = RPG::Weather if RGSS == 1

    def test_superclass
      assert_equal(@@klass.superclass, Object)
    end

    def test_constants
      assert_symset_equal(@@klass.constants, [])
    end

    def test_class_variables
      assert_symset_equal(@@klass.class_variables, [])
    end

    def test_class_methods
      assert_symset_equal(@@klass.methods - Object.methods, [])
    end

    def test_instance_methods
      assert_symset_equal(owned_instance_methods(@@klass), [
        :dispose, :max, :max=, :ox, :ox=, :oy, :oy=, :type, :type=, :update])
    end

    def test_instance_variables
      obj = @@klass.new
      assert_symset_equal(obj.instance_variables, [
        :@max, :@ox, :@oy, :@rain_bitmap, :@snow_bitmap, :@sprites,
        :@storm_bitmap, :@type])
    end

    def test_new
      obj = @@klass.new
      obj = @@klass.new(Viewport.new(0, 0, 0, 0))
      assert_raise(ArgumentError) { @@klass.new(:hoge, :fuga) }
      assert_raise(TypeError) { @@klass.new(:hoge) }

      rain_expected = Bitmap.new("../../src/test/Graphics/rain_bitmap.png")
      snow_expected = Bitmap.new("../../src/test/Graphics/snow_bitmap.png")
      storm_expected = Bitmap.new("../../src/test/Graphics/storm_bitmap.png")

      obj = @@klass.new
      assert_equal(obj.instance_eval("@max"), 0)
      assert_equal(obj.instance_eval("@ox"), 0)
      assert_equal(obj.instance_eval("@oy"), 0)
      assert_bitmap_equal(obj.instance_eval("@rain_bitmap"), rain_expected)
      assert_bitmap_equal(obj.instance_eval("@snow_bitmap"), snow_expected)
      # assert_equal(obj.instance_eval("@sprites"), nil)
      assert_bitmap_equal(obj.instance_eval("@storm_bitmap"), storm_expected)
      assert_equal(obj.instance_eval("@type"), 0)
    end
  end

  if RGSS == 1
    run_test(TestRPGWeather)
  end
end