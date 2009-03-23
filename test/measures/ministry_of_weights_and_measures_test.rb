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
        assert_equal 1, Ministry.parse("m").quantity.exponent
        assert_equal 3, Ministry.parse("m^3").quantity.exponent
        assert_equal 3, Ministry.parse("(m)^3").quantity.exponent
        assert_equal 3, Ministry.parse("(m + n)^3").quantity.exponent
        assert_equal 3, Ministry.parse("(m + n)^3 + 40").quantity.exponent
      end
    end
    
    context "Associativity" do
      should "simplify nested exponents" do
        assert_equal "m^2.0", Ministry.parse("(m)^2").normalize.join
        assert_equal "m^-2.0", Ministry.parse("(m)^-2").normalize.join
        assert_equal "(m^2.0+n^2.0)", Ministry.parse("(m + n)^2").normalize.join
        assert_equal "(m^6.0+n^6.0)", Ministry.parse("(m^3 + n^3)^2").normalize.join
        assert_equal "m^8.0", Ministry.parse("((m^2)**2)^2").normalize.join
        assert_equal "(a^-3.0-b^-3.0-c^-3.0)", Ministry.parse("(a-b-c)**-3").normalize.join
      end
      
      should "distribute multipliers" do
        assert_equal "a*b+a*c", Ministry.parse("a*(b+c)").normalize.join
        assert_equal "a*b*c+a*b*d", Ministry.parse("a*b*(c+d)").normalize.join
      end
    end
    
    should "invert division via negative exponents" do
      assert_equal "a*b^-1", Ministry.parse("a/b").normalize.join
      assert_equal "a*b^-2.0", Ministry.parse("a/b^2").normalize.join
      assert_equal "a^-1.0*b", Ministry.parse("(a/b)^-1").normalize.join
    end
    
    should "get rid of optional parentheses" do
      assert_equal "a", Ministry.parse("(a)").normalize.join
      assert_equal "a+b", Ministry.parse("(a+b)").normalize.join
      assert_equal "a/b", Ministry.parse("a/(b)").normalize.join
    end
    
    should "observe commutativity" do
      assert_equal Ministry.parse("(a/b)").normalize.join, Ministry.parse("(b/a)^-1").normalize.join
    end
  end
end
