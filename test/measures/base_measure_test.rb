require File.dirname(__FILE__) + '/../test_helper'

class BaseMeasureTest < Test::Unit::TestCase

  def setup
    @measure = Smoot.new(4,"kilosmoots")
  end
  
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
  
end