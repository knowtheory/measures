require 'english/inflect'

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

  MEASURE_MAP = {
    :velocity               => "distance/duration",
    :accelleration          => "distance/duration^2",
    :jerk                   => "distance/duration^3",
    :snap                   => "distance/duration^4",
    :crackle                => "distance/duration^5",
    :pop                    => "distance/duration^6",
    :area                   => "distance^2",
    :volume                 => "distance^3",
    :volumetric_flow        => "volume/duration",
    :angular_velocity       => "angle/duration",
    :momentum               => "force*duration",
    :angular_momentum       => "force*distance*duration",
    :torque                 => "force*distance",
    :density                => "mass/volume",
    :wave_number            => "distance^-1",
    :specific_volume        => "distance^3/mass",
    :molar_concentration    => "mole/volume",
    :molar_volume           => "volume/mole",
    :heat_capacity          => "energy/temperature",
    :molar_heat_capacity    => "energy/temperature/mole",
    :specific_heat_capacity => "energy/temperature/mass",
    :molar_energy           => "energy/mole",
    :specific_energy        => "energy/mass",
    :energy_density         => "energy/volume",
    :surface_tension        => "force/distance",
    :irradiance             => "power/area",
    :thermal_conductivity   => "power/distance/temperature",
    :kinematic_viscosity    => "area/duration",
    :dynamic_viscosity      => "pressure*duration",
=begin
    :electric_charge_density  => ,
    :electric_current_density => ,
    :conductivity             => ,
    :molar_conductivity       => ,
    :permittivity             => ,
    :permeability             => ,
    :electric_field_strength  => ,
    :magnetic_field_strength  => ,
    :luminance                => ,
    :absorbed_dose_rate       => ,
=end    
    :resistivity            => "resistance/distance"

    
  }

  class Measure
    @@unit = nil
    @@quantity = nil
    def initialize(value,modifier="base",unit=@@unit,quantity=@@quantity)
      raise ArgumentError, "value has to be a Numeric type (Integer,Float,Fixnum,Bignum). Really now, what'd you think it should be?" unless value.kind_of? Numeric
      raise ArgumentError, "Unit modifier must be 'base' or one of #{Measures::PREFIX_FULL.keys.compact.join(", ")}" unless Measures::PREFIX_FULL.keys.include? modifier
    
      @value =    value.to_f
      @modifier = modifier
      @unit =     unit
      @quantity = quantity
    end

  # ======================================
  # Info & Reporting Methods
  # ======================================
    attr_reader :value, :unit, :quantity
    def to_s
      "#{@value} #{@modifier}#{@unit}"
    end

  # ======================================
  # Comparator Methods
  # ======================================
  
    # Equality operator.  checks if the two quantities (measures after conversion 
    # to common base) are equal or not.
    # returns true or false.
    def ==(obj)
      unless self.compatible? second_arg
        raise ArgumentError, "first argument (#{self}) must be compatible with second argument (#{second_arg}) in order to compare them."
      end
    end
  
    # this method determines whether there is relationship between this measure
    # and the target measure that is only a Numeric difference.
    # In other words, can these two units be converted from one to the other
    # returns the true or false.
    def compatible?(target)
      quantity == target.quantity
    end

  # ======================================
  # Calculation Operations
  # ======================================

    # Addition and subtraction can only be performed between two measures which
    # are compatible? each other.
    def arithmetic(second_argument, operator)
      raise ArgumentError, "operator has to be '+' or '-'" unless ["+","-"].include? operator
      unless self.compatible? second_arg
        raise ArgumentError, "first argument (#{self}) must be compatible with second argument (#{second_arg}) in order to perform #{operator}."
      end
    
      first_value = self.convert_to("base").value
      second_value = second_argument.convert_to(self.unit)
      result = first_value.send(operator,second_value)
    end
  
    def +(addend)
      arithmetic(addend,"+")
    end
  
    def -(subtractor)
      arithmetic(subtractor,"-")
    end
  
    # A measure can be multiplied by either a Numeric scaling factor OR
    # by another measure type.  In the former case, the class remains the same
    # in the latter case, a new ComplexMeasure is returned, with a new unit.
    def *(multiplier)
    end
  
    # A measure can be divided by either a Numeric scaling factor OR
    # by another measure type.  In the former case, the class remains the same
    # in the latter case, a new ComplexMeasure is returned, with a new unit.
    def /(divisor)
    end

  # ======================================
  # Casting & Conversion Methods
  # ======================================  
    def convert_to(target)
    
    end
  
  end

  class BaseMeasure < Measure
    
    
    def si_convert_to(new_modifier)
      raise ArgumentError, "New unit modifier must be a valid SI prefix (#{Measures::PREFIX_FULL.keys.compact.join(",")})" unless Measures::PREFIX_FULL.keys.include? new_modifier
      modifier_order_of_magnitude = Measures::PREFIX_FULL[@multiple_modifier]
      new_order_of_magnitude    = Measures::PREFIX_FULL[new_modifier]

      power_conversion = modifier_order_of_magnitude - new_order_of_magnitude
      new_value = @value * 10**power_conversion
      self.class.new(new_value,new_modifier)
    end
  
    def self.inherited(subclass)
      @@unit = subclass.to_s.plural.downcase
      Measures::PREFIX_FULL.keys.compact.each do |modifier|
        subclass.class_eval <<-evalblock
          def #{modifier}#{@@unit}
            convert_to("#{modifier}")
          end
        evalblock
      end
    end
  end

  class ComplexMeasure < Measure
  
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
