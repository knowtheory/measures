require File.dirname(__FILE__) + '/../test_helper'

class MinistryOfWeightsAndMeasuresTest < Test::Unit::TestCase
  context "The Ministry of Weights and Measures" do
    context "Class registration" do
      setup do
        Ministry.reset!
        class Arm < Measures::Measure
          defined_as "distance" 
          abbreviated_as "a"
          aka "Wing"
        end
      end
    
      should "record registered measures" do
        assert Ministry.abbreviations.include?("a")
        assert_equal Ministry.abbreviations["a"], Arm
        assert Arm.new(3)
      end
    end
    
    should "factor a definition into it a base definition" do
      assert_equal [], Ministry.factor("C/V")
    end
  end
end