require File.dirname(__FILE__) + '/../test_helper'

class BaseMeasureTest < Test::Unit::TestCase
  def setup
    @measure = Measures::BaseMeasure.new(4,"kilo")
  end
  
  def test_internal_value_for_measure
    assert @measure = Measures::BaseMeasure.new(4,"yocto")
    assert_equal 4, @measure.value
  end
  
  def test_internals_after_conversion_to_base_for_measures
    assert @measure
    assert_equal 4000, @measure.convert_to("base").value
  end
  
  def test_abstract_measure_class_prefix_conversion
    assert @measure
    assert_equal 400, @measure.convert_to("deca").value
  end
  
  def test_abstract_measure_class_prefix_conversion_is_chainable
    assert @measure
    assert_equal 4, @measure.convert_to("deca").convert_to("kilo").value
  end
end