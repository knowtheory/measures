require File.dirname(__FILE__) + '/../test_helper'

class MeasureTest < Test::Unit::TestCase
  def setup
    @measure = Measures::Measure.new(4,"kilo")
  end

  def test_abstract_measure_class
    assert Measures::Measure.new(4)
    assert Measures::Measure.new(4,"base")
    assert Measures::Measure.new(4,"kilo")
  end

  def test_comparison_of_compatible_measures
    assert @m1 = Measures::Measure.new(48,"base","metre","distance")
    assert @m2 = Measures::Measure.new(4800,"centi","metre","distance")
    assert @m3 = Measures::Measure.new(800,"centi","metre","distance")
    assert @m1.compatible?(@m1)
    assert @m1.compatible?(@m2)
    assert @m2.compatible?(@m1)
    assert @m1.compatible?(@m3)
    assert @m2.compatible?(@m3)
    assert @m3.compatible?(@m1)
    assert @m3.compatible?(@m2)
  end
  
  def test_comparison_of_incompatible_measures
    
  end

  def test_arithmetic_on_measures
    
  end
  
  def test_multiplication_of_measures
  end
  
  def test_division_of_measures
  end

end