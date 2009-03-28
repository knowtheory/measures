class Second < Measures::Measure
  defined_as "duration"
  abbreviated_as "s"
  
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
end