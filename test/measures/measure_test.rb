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

  def test_equality
    assert @m1 = Measures::Measure.new(48,"base","metre","distance")
    assert @m2 = Measures::Measure.new(4800,"centi","metre","distance")
    assert @m3 = Measures::Measure.new(800,"centi","metre","distance")
    assert              @m1 == @m2
    assert              @m2 == @m1
    assert_equal false, @m1 == @m3
    assert_equal false, @m2 == @m3
    assert_equal false, @m3 == @m1
    assert_equal false, @m3 == @m2
  end

  def test_arithmetic_on_measures
    
  end
  
  def test_multiplication_with_numerics
    assert @m1 = Measures::Measure.new(5,"base","metre","distance")
    assert_equal 10, (@m1*2).value
    assert_equal Measures::Measure.new(10,"base","metre","distance"), (@m1*2)
  end
  
  def test_multiplication_of_similar_measures
    assert @m1 = Measures::Measure.new(5,"base","metre","distance")
    assert @m2 = Measures::Measure.new(500,"centi","metre","distance")
    assert_equal Measures::ComplexMeasure.new(25,"base","metre^2","area"), @m1*@m2
  end
  
  def test_multiplication_of_different_measures
    assert @m = Measures::Measure.new(5,"base","metre","distance")
    assert @n = Measures::Measure.new(3,"base","newton","force")
    assert_equal Measures::ComplexMeasure.new(15,"base","newton*metre","force*distance"), (@n*@m)
    assert_equal Measures::ComplexMeasure.new(15,"base","newton*metre","force*distance"), (@m*@n) # test transitivity
  end
  
  def test_division_of_measures
  end

end