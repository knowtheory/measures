=begin
  Extend Numeric with the following abilities:
    #cast_units(prefix=nil,units) which proxies to the appropriate class
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
              nil       => 0,   # i don't know whether this is potentially dangerous or not since 
              "base"    => 0,   # it allows for passing nil as a valid arg in various places
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
  
  # MAKE SURE TO CALL THIS METHOD FOR ALL YOUR UNIT CLASSES
  # WHICH DESCEND FROM MEASURE
  def add_prefix_methods
    Measures::PREFIX_FULL.keys.compact.each do |prefix| 
      define_method("#{prefix}#{@@unit}".to_sym){ general_conversion_to(prefix) }
    end
  end

  class Measure
    # OVERRIDE THESE WITH YOUR UNIT'S INFO
    @@unit = nil
    @@unit_abbreviated = nil
    def initialize(value,prefix=nil) # length should be able to define an order=1 parameter
      raise ArgumentError, "Unit prefix must be nil or a valid SI prefix (#{Measures::PREFIX_FULL.keys.compact.join(",")})" unless Measures::PREFIX_FULL.keys.include? prefix
      raise ArgumentError, "value has to be a Numeric type (Integer,Float,Fixnum,Bignum). Really now, what'd you think it should be?" unless value.kind_of? Numeric
      
      @value = value
      @prefix = prefix
    end
    
    def to_s
      @value.to_s
    end
    
    def inspect
      @value
    end
    
    def to_base
      @value * 10**Measures::PREFIX_FULL[@prefix]
    end
    
    def +(addend)
      unless self.class == addend.class
        raise ArgumentError, "Addend (#{addend.to_s}:#{addend.class}) must be the same class of object as our quantity (#{self.to_s}:#{self.class})"
      end
      
      
    end
    
    def *(multiplier)
      unless multiplier.kind_of?(Numeric)# or self.class == multiplier.class
        raise ArgumentError, "Multiplier (#{multiplier.to_s}:#{multiplier.class}) must be a Numeric type (Integer/Float/Fixnum/Bignum)"
#        raise ArgumentError, "Multiplier (#{multiplier.to_s}:#{multiplier.class}) must either be the same class as multiplicand (#{self.to_s}:#{self.class}) or a Numeric type (Integer/Float/Fixnum/Bignum)"
      end
      
      coerce_to_floate = self.magnitude
      if multiplier.kind_of? Numeric
        new_value = self.to_base * multiplier
      else
        new_value = self.to_base * multiplier.to_base
      end
    end
    
    # Here's where the magic takes place
    def general_conversion_to(new_prefix)
      raise ArgumentError, "New unit prefix must be a valid SI prefix (#{Measures::PREFIX_FULL.keys.compact.join(",")})" unless Measures::PREFIX_FULL.keys.include? new_prefix
      prefix_order_of_magnitude = Measures::PREFIX_FULL[@prefix]
      new_order_of_magnitude    = Measures::PREFIX_FULL[new_prefix]

      power_conversion = prefix_order_of_magnitude - new_order_of_magnitude
      @value * 10**power_conversion
    end
  end
end