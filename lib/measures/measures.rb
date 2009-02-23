require 'english/inflect'

module Measures

=begin
  unless Measures.const_defined? :PREFIX_FULL
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
  end
  
  unless Measures.const_defined? :PREFIX_ABBREVIATED
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
  end
=end
  module MeasureProperties
    attr_reader :quantity, :definition, :factored_definition, :abbreviation, :aliases
    
    def defined_as(quantity, definition="base")
      # set the class instance variables
      instance_variable_set("@quantity", quantity)
      instance_variable_set("@factored_definition", MinistryOfWeightsAndMeasures.factor(definition) )
      instance_variable_set("@definition", definition)
      
      # register class w/ the Ministry of Weights and Measures
      MinistryOfWeightsAndMeasures.register_measure(self,quantity,definition)
    end
    
    def abbreviated_as(abbreviation)
      MinistryOfWeightsAndMeasures.register_measure_abbreviation(self,abbreviation)
      instance_variable_set("@abbreviation",abbreviation)
    end
    
    def aka(*aliases)
      instance_variable_set("@aliases",aliases)
      # register aliases w/ Ministry of Weights and Measures
    end
  end
  
  module Conversion
    def convert_to(destination)
      
    end
  end
  
  module Calculation
    
    
    def +(addend)
      # check measures are compatable
      
      # convert to common base
      
      # perform subtraction
      
    end
    
    def -(subtractor)
      # check measures are compatable
      
      # convert to common base
      
      # perform subtraction
      
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
      self.class.quantity == object.class.quantity or     # if the quantities are named and identical
      self.class.definition == object.class.definition or # or the definitions are the same then yay
      MinistryOfWeightsAndMeasures.factor(self.class.definition) == MinistryOfWeightsAndMeasures.factor(object.class.definition)
    end
  end
  
  module Reporting
    def to_s
      "#{@value} "
    end
    
    def self.basic?
      
    end
    
    def self.complex?
      
    end
  end
  
  class Measure
    # cheating on class variables.
    # Since class variables are shared amongst subclasses
    # we're adding instance variables to the class objects themselves.
    extend MeasureProperties
    include Calculation, Comparitors, Conversion, Reporting
    
    def initialize(value,definition=self.class.definition,options={})
      # definition for a measure has to be compatable w/ it's subclass's definition
      if self.class.definition and 
      not MinistryOfWeightsAndMeasures.equivalent?(self.class.definition, definition)
        message = "An instance of #{self.class.to_s} can't be created w/ a definition other than itself"
        raise ArgumentError, message
      end
      
      @value = value
    end
  end
end