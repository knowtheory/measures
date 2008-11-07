require 'rubygems'
require 'test/unit'
require 'lib/measures'
require 'shoulda'

class Smoot < Measures::BaseMeasure # 1.701 m
  @@quantity      = "distance"
  # this should automatically add methods which will be tested.
end