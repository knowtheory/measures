require 'english/inflect'
=begin
  Extend Numeric with the following abilities:
    #cast_units(modifier=nil,units) which proxies to the appropriate class
    #define_measures() which defines a series of methods 
=end

module Measures
  PREFIX_FULL = {  
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

  PREFIX_ABBREVIATED = {
              "y"  => "yocto",
              "z"  => "zepto",
              "a"  => "atto",
              "f"  => "fempto",
              "p"  => "pico",
              "n"  => "nano",
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

  class Measure
    # OVERRIDE THESE WITH YOUR UNIT'S INFO
    @@unit = nil
    @@unit_aliases = [] 
    @@measure = nil     # (i.e. :distance, mass, time) used for identifying classes that can be converted between each other.
    
    attr_reader :value
    def initialize(value,modifier="base") # length should be able to define an order=1 parameter
      raise ArgumentError, "value has to be a Numeric type (Integer,Float,Fixnum,Bignum). Really now, what'd you think it should be?" unless value.kind_of? Numeric
      raise ArgumentError, "Unit modifier must be 'base' or a valid SI prefix (#{Measures::PREFIX_FULL.keys.compact.join(", ")})" unless Measures::PREFIX_FULL.keys.include? modifier
      
      @value = value.to_f
      @multiple_modifier = modifier
    end
    
    def to_s
      "#{@value} #{@multiple_modifier}#{@@unit.plural.downcase}"
    end
    
    def ==(obj)
      if self.class == obj.class
        return self.to_base.value == obj.to_base.value
      else
        raise ArgumentError, "Compared object (#{obj}:#{obj.class}) must be the same class as what it's being compared to (#{self}:#{self.class})"
      end
    end
    
    def +(addend)
      unless self.class == addend.class
        raise ArgumentError, "Addend (#{addend.to_s}:#{addend.class}) must be the same class of object as our quantity (#{self.to_s}:#{self.class})"
      end
      
      @value += addend.convert_to("base")
      return self
    end
    
    def *(multiplier)
      unless multiplier.kind_of?(Numeric)
        raise ArgumentError, "Multiplier (#{multiplier.to_s}:#{multiplier.class}) must be a Numeric type (Integer/Float/Fixnum/Bignum)"
      end
      
      if multiplier.kind_of? Numeric
        new_value = self.to_base * multiplier
      end
    end
    
    def /(divisor)
      unless multiplier.kind_of?(Numeric)
        raise ArgumentError, "Multiplier (#{multiplier.to_s}:#{multiplier.class}) must be a Numeric type (Integer/Float/Fixnum/Bignum)"
      end
    end

    # returns a new object w/ value set to base measure
    def to_base
      self.class.new(@value * 10**Measures::PREFIX_FULL[@multiple_modifier])
    end
    
    def convert_to(target)
      si_convert_to(target)
    end
    
    # Here's where the magic takes place
    def si_convert_to(new_modifier)
      raise ArgumentError, "New unit modifier must be a valid SI prefix (#{Measures::PREFIX_FULL.keys.compact.join(",")})" unless Measures::PREFIX_FULL.keys.include? new_modifier
      modifier_order_of_magnitude = Measures::PREFIX_FULL[@multiple_modifier]
      new_order_of_magnitude    = Measures::PREFIX_FULL[new_modifier]

      power_conversion = modifier_order_of_magnitude - new_order_of_magnitude
      new_value = @value * 10**power_conversion
      self.class.new(new_value,new_modifier)
    end
    
    # This is some of where the magic takes place.
    # Descendent classes of Measure will have a set of methods added to them
    # so that users will be able to do standard base-10 unit conversion.
    def self.inherited(subclass)
      Measures::PREFIX_FULL.keys.compact.each do |modifier|
        subclass.class_eval <<-evalblock
          def #{modifier}#{subclass.to_s.plural.downcase}
            si_convert_to("#{modifier}")
          end
        evalblock
      end
    end
=begin
require 'lib/measures'
class Metre < Measures::Measure
  @@unit = "Metre"
  @@measure = "distance"
  @@unit_aliases = ["meter", "m"]
end
Metre.new(4,"kilo").centimetres
Metre.new(4,"kilo") == Metre.new(4000)
=end
  end
end # module