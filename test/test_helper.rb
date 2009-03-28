#$:.push File.join(File.dirname(__FILE__), '..', 'lib')

require 'rubygems'
require 'test/unit'
require 'shoulda'
require 'lib/measures'

class Smoot < Measures::Measure # 1.701 m
  defined_as "distance"
  abbreviated_as "sm"
  # this should automatically add methods which will be tested.
end

class Sabre < Measures::Measure # fictional measure that == 30 inches
  defined_as "distance"
  abbreviated_as "sab"
  aka "saber"
end