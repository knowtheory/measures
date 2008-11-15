require 'measures'

class Metre < Measure::BaseMeasure
  @@quantity      = "distance"
  @@aliases  = {:abbreviation => "m", :aliases => ["meter"]}
end

class Gram < Measure::BaseMeasure
  @@quantity      = "mass"
  @@aliases  = {:abbreviation => "g", :aliases => ["gramme"]}
end

class Ampere < Measure::BaseMeasure
  @@quantity      = "current"
  @@aliases  = {:abbreviation => "A", :aliases => ["amp"]}
end

class Kelvin < Measure::BaseMeasure
  @@quantity      = "temperature"
  @@aliases  = {:abbreviation => "K"}
end

class Candela < Measure::BaseMeasure
  @@quantity      = "luminous_intensity"
  @@aliases  = {:abbreviation => "cd"}
end

class Mole < Measure::BaseMeasure
  @@quantity      = "mole"
  @@aliases  = {:abbreviation => "mol"}
end

module InternationalSystem
  BASE_MEASURES = {
    :distance           => Metre,
    :mass               => Gram,
    :current            => Ampere,
    :temperature        => Kelvin,
    :luminous_intensity => Candela,
    :mole               => Mole
  }
end