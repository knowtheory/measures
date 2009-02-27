require File.dirname(__FILE__) + '/../test_helper'

class Arm < Measures::Measure
  defined_as "distance" 
  abbreviated_as "a"
  aka "Wing"
end

class MinistryOfWeightsAndMeasuresTest < Test::Unit::TestCase
  context "The Ministry of Weights and Measures" do
    context "Class registration" do
      should "record registered measures" do
        assert Ministry.abbreviations.include?("a")
        assert_equal Ministry.abbreviations["a"], Arm
        assert Arm.new(3)
      end
    end
    
    should "factor definition of a base class to itself" do
      assert "arm", Ministry.factor("arm")
    end
  end
end