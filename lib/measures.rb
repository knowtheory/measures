$:.push(File.dirname(__FILE__))
# -*- coding: utf-8 -*-
require 'english/inflect'
require 'ministry_of_weights_and_measures'
require 'modifiers/named_quantities'

module Measures

  module MeasureProperties
    attr_reader :quantity, :definition, :factored_definition, :abbreviation, :aliases
    
    # Interesting fact:
    #   By storing the factored definitions for each class,
    #   definition parse trees are in effect memoized for
    #   subsequent classes which reference a defined class.
    def defined_as(quantity, definition=self.to_s.split("::").last.downcase)
      # set the class instance variables
#      puts "Definition is #{definition}"

      definition_tree = Ministry.parse(definition)
      
      instance_variable_set("@quantity", quantity)
      instance_variable_set("@definition", definition_tree)
      # register class w/ the Ministry of Weights and Measures
      # not sure why i'm passing the definition atm :P TODO!!
      MinistryOfWeightsAndMeasures.register_measure(self,quantity,definition_tree)
      if self.to_s.split("::").last.downcase == definition
        factored_definition = Ministry.parse(definition)
      else
        factored_definition = MinistryOfWeightsAndMeasures.factor(definition_tree)
      end
      instance_variable_set("@factored_definition", factored_definition )
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
    def convert_to(target)
      if definition == :base
        definition = self.class.definition
      end
      modifier = Ministry.conversion_factor(self.definition, definition)
      self.value * modifier
    end
  end
  
  module Calculation
    
    
    def +(addend); arithmetic_op(:+,addend) ;end
    def -(subtractor); arithmetic_op(:-,subtractor); end
    def arithmetic_op(operation, operand)
      # check measures are compatable
      
      # convert to common base
      
      # perform addition
      
    end
    
    def *(multiplicand)
      
    end
    
    def /(divisor)
      
    end
  end
  
  module Comparitors
    def ==(object)
      self.compatible_with?(object) and     # result should be false if they're not compatable
      self.convert_to(:base) == object.convert_to(:base)  # do conversion for comparison
    end
    
    def compatible_with?(object)
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
    attr_accessor :definition, :factored_definition, :value
    # cheating on class variables.
    # Since class variables are shared amongst subclasses
    # we're adding instance variables to the class objects themselves.
    extend MeasureProperties
    include Calculation, Comparitors, Conversion, Reporting
    
    def initialize(value,definition=self.class.definition,options={})
      # definition for a measure has to be compatable w/ it's subclass's definition
      if self.class.definition and 
      not MinistryOfWeightsAndMeasures.equivalent?(self.class.definition, definition)
        message = "An instance of #{self.class.to_s} can't be created w/ a definition (#{definition}) other than itself (#{self.class.definition})"
        raise ArgumentError, message
      end
      
      @value = value
      @defintion = definition
    end
  end
end