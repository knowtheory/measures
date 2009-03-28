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
  
  context "Definition Factoring" do
    context "Quantities" do
      should "always have an exponent" do
        pairs = [["m", 1], ["m^3",3], ["(m + n)^3",3]]
        pairs.each do |input,value|
          tree = Ministry.parse(input)
          assert tree.class == Definition::QuantityNode, "Root for '#{input}' was #{tree.class} instead of Definition::QuantityNode"
          assert_equal value, tree.exponent
        end
        assert_equal 3, Ministry.parse("(m + n)^3 + 40").quantity.exponent
      end
    end
    
    context "Associativity" do
      should "distribute nested exponents" do
        inputs = [["(m^2.0)", "m^2.0", "(m)^2"],
                  ["(m^-2.0)", "m^-2.0", "(m)^-2"],
                  ["(m^2.0+n^2.0)", "m^2.0+n^2.0", "(m + n)^2"],
                  ["(m^6.0+n^6.0)", "m^6.0+n^6.0", "(m^3 + n^3)^2"],
                  ["((m^8.0))", "m^8.0", "((m^2)**2)^2"]]
        inputs.each do |distributed,simplified,input|
          assert_equal distributed, Ministry.parse(input).tokens(:distribute=>true).join
          assert_equal simplified, Ministry.parse(input).tokens(:distribute=>true,:simplify=>true).join
        end
        assert_equal "(a^-3.0-b^-3.0-c^-3.0)", Ministry.parse("(a-b-c)**-3").tokens(:distribute=>true).join
      end
      
      should "distribute multipliers" do
        assert_equal "a*b+a*c", Ministry.parse("a*(b+c)").normalize.join
        assert_equal "a*b+a*c", Ministry.parse("(b+c)*a").normalize.join
        assert_equal "a*b*c+a*b*d", Ministry.parse("a*b*(c+d)").normalize.join
      end
    end
    
    context "Commutativity" do
      should "sort tree output to observe commutativity" do
        inputs = [["a + b",       "b + a"],
                  ["a * b",       "b * a"],
                  ["a + b + c",   "c + b + a"],
                  ["a + b + c",   "b + c + a"],
                  ["a * b * c",   "c * b * a"],
                  ["a * b * c",   "b * c * a "],
                  ["(a/b)",       "(b/a)^-1"]]
        inputs.each do |canonical,alternate|
          assert_equal Ministry.parse(canonical).normalize.join, Ministry.parse(alternate).normalize.join
        end
      end
    end
    
    should "invert division via negative exponents" do
      assert_equal "a*b^-1", Ministry.parse("a/b").normalize.join
      assert_equal "a*b^-2.0", Ministry.parse("a/b^2").normalize.join
      assert_equal "a^-1.0*b", Ministry.parse("(a/b)^-1").normalize.join
    end
    
    should "get rid of optional parentheses" do
      assert_equal "a", Ministry.parse("(a)").tokens(:simplify=>true).join
      assert_equal "a+b", Ministry.parse("(a+b)").tokens(:simplify=>true).join
      assert_equal "a/b", Ministry.parse("a/(b)").tokens(:simplify=>true).join
    end
    
  end
end
