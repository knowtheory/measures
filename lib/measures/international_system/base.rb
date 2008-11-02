require 'measures'

class Metre < Measure::BaseMeasure
  @@quantity      = "distance"
  @@unit_aliases  = {:abbreviation => "m", :alternates => ["meter"]}
end

class Gram < Measure::BaseMeasure
  @@quantity      = "mass"
  @@unit_aliases  = {:abbreviation => "g", :alternates => ["gramme"]}
end

class Ampere < Measure::BaseMeasure
  @@quantity      = "current"
  @@unit_aliases  = {:abbreviation => "A", :alternates => ["amp"]}
end

class Kelvin < Measure::BaseMeasure
  @@quantity      = "temperature"
  @@unit_aliases  = {:abbreviation => "K"}
end

class Candela < Measure::BaseMeasure
  @@quantity      = "luminous_intensity"
  @@unit_aliases  = {:abbreviation => "cd"}
end

class Mole < Measure::BaseMeasure
  @@quantity      = "mole"
  @@unit_aliases  = {:abbreviation => "mol"}
end