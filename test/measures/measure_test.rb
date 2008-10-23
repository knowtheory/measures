require File.dirname(__FILE__) + '/../test_helper'

class MeasureTest < Test::Unit::TestCase
  # def setup
  # end

  # def teardown
  # end

  def test_abstract_measure_class
    assert @measure = Measures::Measure.new(4)
  end
  
  def test_abstract_measure_class_with_prefix
    assert @measure = Measures::Measure.new(4,"kilo")
    assert_equal 4000, @measure.to_base.instance_variable_get("@value")
  end
  
  def test_abstract_measure_class_prefix_conversion
    test_abstract_measure_class_with_prefix
    assert_equal 400, @measure.convert_to("deca").instance_variable_get("@value")
  end
  
  def test_abstract_measure_class_prefix_conversion_is_chainable
    test_abstract_measure_class_with_prefix
    assert_equal 4, @measure.convert_to("deca").convert_to("kilo").instance_variable_get("@value")
  end
  
  
end