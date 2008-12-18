require File.dirname(__FILE__) + '/../test_helper'

class MinistryOfWeightsAndMeasuresTest < Test::Unit::TestCase
  context "The Ministry of Weights and Measures" do
#    context "with metric base classes registered" do
#      setup do
#        require 'measures/international_system/base'
#      end
      
      should "parse and map abbreviations to their correct defintions" do
        MinistryOfWeightsAndMeasures #.factor("mm")
      end
#    end
  end
end