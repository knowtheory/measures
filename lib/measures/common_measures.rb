require 'lib/measures'

class Second < Measures::Measure
  DURATIONS = {
    "minute"  => 60,
    "hour"    => 3600,
    "day"     => 86400,
    "year"    => 31557600
  }
  
  DURATIONS_ABBREVIATED = {
    "min"     => "minute",
    "h"       => "hour",
    "d"       => "day",
    "a"       => "year"
  }
  DURATIONS_REGEXP =              Regexp.new(DURATIONS.keys.compact.join("|"))
  DURATIONS_ABBREVIATED_REGEXP =  Regexp.new(DURATIONS.keys.compact.join("|"))
  
  def convert_to(modifier)
    if DURATIONS_REGEXP =~ modifier or DURATIONS_ABBREVIATED_REGEXP =~ modifier
      (@value * DURATIONS[@multiple_modifier]) 
    elsif PREFIX_FULL_REGEXP =~ modifier or PREFIX_ABBREVIATED_REGEXP =~ modifier
      si_convert_to(modifier)
    end
  end
end

class Celsius < Measures::Measure
end