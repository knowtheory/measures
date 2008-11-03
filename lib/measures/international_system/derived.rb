class Hertz < Measure::ComplexMeasure
  @@quantity      = "frequency"
  @@unit          = "s^-1"
  @@unit_alias    = {:abbreviation => "Hz"}
end

class Radian < Measure::ComplexMeasure
  @@quantity      = "angle"
  @@unit          = "m/m" # m/m
  @@unit_alias    = {:abbreviation => "rad"}
end

class Steradian < Measure::ComplexMeasure
  @@quantity      = "solid_angle"
  @@unit          = "m^2/m^2" # m^2/m^2?
  @@unit_alias    = {:abbreviation => "sr"}
end

class Newton < Measure::ComplexMeasure
  @@quantity      = "force"
  @@unit          = "m*kg/s^2"
  @@unit_alias    = {:abbreviation => "N", :aliases => []}  
end

class Pascal < Measure::ComplexMeasure
  @@quantity      = "pressure"
  @@unit          = "N/m^2"
  @@unit_alias    = {:abbreviation => "", :aliases => []}
end
=begin
class < Measure::ComplexMeasure
  @@quantity      = ""
  @@unit          = ""
  @@unit_alias    = {:abbreviation => "", :aliases => []}
end
=end