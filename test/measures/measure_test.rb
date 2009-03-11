require File.dirname(__FILE__) + '/../test_helper'

class MeasureTest < Test::Unit::TestCase
  
  context "Generic Base Measures" do
    should "be definable" do
      assert Measures::Measure.new(25,"sm^2")
    end
    
    should "be equal to a composite of defined measures" do
      square_smoots = Smoot.new(5) * Smoot.new(5)
      assert_equal square_smoots, Measures::Measure.new(25,"sm*sm")
    end
    
    should "identify as itself" do
      assert_equal Smoot.new(5), Smoot.new(5)
    end
    
    should "not identify as someone different" do
      assert_not_equal Smoot.new(5), Smoot.new(6)
    end
    
    should "identify as other equivalent measures" do
      assert_equal Smoot.new(5000), Smoot.new(5,"kilo.smoot")
    end
    
    should "be comparable" do
      assert Smoot.new(5).compatible_with? Smoot.new(6)
    end
  end
=begin  
  should "represent value as a float internally" do
    assert @measure = Smoot.new(4,"yoctosmoots")
    assert_equal 4, @measure.value
  end
  
  should "convert from prefixed measure to base measure" do
    assert @measure
    assert_equal 4000, @measure.convert_to("smoots").value
  end
  
  should "convert from prefixed measure to a different prefixed measure" do
    assert @measure
    assert_equal 400, @measure.convert_to("decasmoots").value
  end
  
  should "convert from base measure to prefixed measure" do
    assert @measure = Smoot.new(4,"smoots")
  end
  
  should "allow for measure conversions to be chainable" do
    assert @measure
    assert_equal 4, @measure.convert_to("deca").convert_to("kilo").value
  end
  
  should "return true when equivalent measures are compared" do
    assert_equal Measures::Measure.new(1,"N/C"), Measures::Measure.new(1,"V/m")
  end
=end
  
=begin
  should "tokenize accepts empty string" do
    assert_equal {}, Measures.tokenize_unit("")
  end

  should "tokenize base unit" do
    assert_equal {:unit=>""}, Measures.tokenize_unit("")
  end

  should "tokenize prefixed measures"
    assert_equal {:unit=>"Gram", :prefix=>"kilo"}, Measures.tokenize_unit("kilogram")
    assert_equal {:unit=>"Gram", :prefix=>"kilo"}, Measures.tokenize_unit("kilograms")
  end

  should "tokenize measures using name alternates" do
    assert_equal {:unit=>"Gram", :prefix=>"kilo"}, Measures.tokenize_unit("kilogramme")
    assert_equal {:unit=>"Gram", :prefix=>"kilo"}, Measures.tokenize_unit("kilogrammes")
  end

  should "tokenize abbreviated measures" do
    assert_equal {:unit=>"Gram", :prefix=>"kilo"}, Measures.tokenize_unit("kg")
  end
=end

=begin  
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
=end
end