require File.dirname(__FILE__) + '/../test_helper'

class UseCaseTest < Test::Unit::TestCase
=begin
  User.blood_glucose.in("mg/dL")  # normally stored in mmol/L
  5.kilometres.in.feet
=end
  should "provide measure creation methods on numeric classes" do
    5#.kilometres
  end
end