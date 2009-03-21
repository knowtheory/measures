require File.dirname(__FILE__) + '/../test_helper'
require 'metric/metric'

class UseCaseTest < Test::Unit::TestCase
=begin
  User.blood_glucose.in("mg/dL")  # normally stored in mmol/L
  5.kilometres.in.feet
=end
  should "provide measure creation methods on numeric classes" do
    assert true
  end
=begin  
  should "find metric units to be equivalent" do
    assert Ministry.equivalent?("metre","metre")
    assert Ministry.equivalent?("m", "m")
    assert Ministry.equivalent?("J", "(N*m)")
    assert Ministry.equivalent?("J", "N*m")
    assert Ministry.equivalent?("N*m", "C*V")
    assert Ministry.equivalent?("C*V", "W*s")
    assert Ministry.equivalent?("F", "C/V")
    assert Ministry.equivalent?("F", "(s*A)/(W/A)")
    assert Ministry.equivalent?("F", "(s*A)/((J/s)/A)")
    assert Ministry.equivalent?("F", "(s*A)/(J/(s*A))")
    assert Ministry.equivalent?("F", "(s*s*A*A)/J")
    assert Ministry.equivalent?("F", "(s^2*A^2)/J")
  end
=end
end