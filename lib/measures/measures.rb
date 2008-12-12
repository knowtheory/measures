require 'english/inflect'

module Measures
  PREFIX_FULL = 
  {  # definition of prefixes as powers of 10
    "yocto"   => -24,
    "zepto"   => -21,
    "atto"    => -18,
    "fempto"  => -15,
    "pico"    => -12,
    "nano"    => -9, 
    "micro"   => -6, 
    "milli"   => -3, 
    "centi"   => -2, 
    "deci"    => -1, 
    "base"    => 0,
    "deca"    => 1,  
    "hecto"   => 2,  
    "kilo"    => 3,  
    "mega"    => 6,  
    "giga"    => 9,  
    "tera"    => 12, 
    "peta"    => 15, 
    "exo"     => 18, 
    "zetta"   => 21, 
    "yotta"   => 24, 
  }

  PREFIX_ABBREVIATED = 
  {
    "y"  => "yocto",
    "z"  => "zepto",
    "a"  => "atto",
    "f"  => "fempto",
    "p"  => "pico",
    "n"  => "nano",
    "mu" => "micro",
    "μ"  => "micro",
    "m"  => "milli",
    "c"  => "centi",
    "d"  => "deci",
    "da" => "deca",
    "h"  => "hecto",
    "k"  => "kilo",
    "M"  => "mega",
    "G"  => "giga",
    "T"  => "tera",
    "P"  => "peta",
    "E"  => "exo",
    "Z"  => "zetta",
    "Y"  => "yotta",
  }
  
  PREFIX_FULL_REGEXP =        Regexp.new(Measures::PREFIX_FULL.keys.compact.join("|"))
  PREFIX_ABBREVIATED_REGEXP = Regexp.new(Measures::PREFIX_ABBREVIATED.keys.compact.join("|"))

  module MeasureProperties
    attr_reader :quantity, :definition, :abbreviation, :aliases
    
    def defined_as(quantity, definition="base")
      # set the class instance variables
      instance_variable_set("@quantity", quantity)     unless @quantity
      instance_variable_set("@definition", definition) unless @definition
      
      # register class w/ the Ministry of Weights and Measures
    end
    
    def aka(*aliases)
      instance_variable_set("@aliases",aliases)
    end
  end
  
  module Calculation
    def +(addend)
    end
    
    def -(subtractor)
    end
    
    def *(multiplicand)
    end
    
    def /(divisor)
    end
  end
  
  module Comparitors
    def ==(object)
      result = self.compatable_with?(object) # result should be false if they're not compatable
      # do conversion for comparison
    end
    
    def compatable_with?(object)
      self.class.definition == object.class.definition
    end
  end
  
  module Display
    
  end
  
  class Measure
    # cheating on class variables.
    # Since class variables are shared amongst subclasses
    # we're adding instance variables to the class objects themselves.
    extend MeasureProperties
    
    def initialize(value,modifier,options={})
    end
  end
  
  class BaseMeasure < Measure
    
  end
  
  class ComplexMeasure < Measure
    
  end
  
end