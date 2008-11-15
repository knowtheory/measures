require File.dirname(__FILE__) + '/../test_helper'

class MeasureTest < Test::Unit::TestCase
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
end