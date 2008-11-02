require File.dirname(__FILE__) + '/../test_helper'

class ComplexMeasureTest < Test::Unit::TestCase
  def test_implement_tests
    true
  end
  
  def test_conversion_to_basic_unit_formula
  end
  
  def test_comparison_of_equivalent_units
    assert_equal Measures::ComplexMeasure.new(1,"base","N/C"), Measures::ComplexMeasure.new(1,"base","V/m")
  end
  
  def test_cancellation_of_units
    # m/m, km/km, m*m^-1, and km*km^-1 should cancel (return unitless)
    assert_equal Measures::ComplexMeasure.new(1,"base","m/m","angle"), Measures::ComplexMeasure.new(1)
  end
end