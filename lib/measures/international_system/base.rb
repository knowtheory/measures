require 'measures'
module InternationalSystem
  class Metre < Measure::BaseMeasure
    defined_as "distance"
    abbreviated_as "m"
    aka "meter"
  end

  class Gram < Measure::BaseMeasure
    defined_as "mass"
    abbreviated_as "g"
    aka "gramme"
  end

  class Ampere < Measure::BaseMeasure
    defined_as "current"
    abbreviated_as "A"
    aka "amp"
  end

  class Kelvin < Measure::BaseMeasure
    defined_as "temperature"
    abbreviated_as "K"
  end

  class Candela < Measure::BaseMeasure
    defined_as "luminous_intensity"
    abbreviated_as "cd"
  end

  class Mole < Measure::BaseMeasure
    defined_as "amount"
    abbreviated_as "mol"
  end
end