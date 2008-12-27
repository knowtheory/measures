require File.dirname(__FILE__) + '/../measures'
require File.dirname(__FILE__) + '/../ministry_of_weights_and_measures'
module Metric
  class Metre < Measures::Measure
    defined_as "distance"
    abbreviated_as "m"
    aka "meter"
  end

  class Gram < Measures::Measure
    defined_as "mass"
    abbreviated_as "g"
    aka "gramme"
  end

  class Ampere < Measures::Measure
    defined_as "current"
    abbreviated_as "A"
    aka "amp"
  end

  class Kelvin < Measures::Measure
    defined_as "temperature"
    abbreviated_as "K"
  end

  class Candela < Measures::Measure
    defined_as "luminous_intensity"
    abbreviated_as "cd"
  end

  class Mole < Measures::Measure
    attr_reader :molar_mass, :substance
    defined_as "amount"
    abbreviated_as "mol"
    
    def initialize(value,definition=self.class.definition,options={})
      super.initialize(value,definition,options)
      @molar_mass = Measure.new(options[:molar_mass],"mol/g",:quantity=>"molar_mass") if options[:molar_mass]
      @substance = options[:substance]
    end
  end
end