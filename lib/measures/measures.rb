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
    # measure of              # description/derivation              # unit derivation in SI
    :frequency                => "duration^-1",                     # => 1/s
    :angle                    => "",                                # => m/m
    :solid_angle              => "",                                # => m^2/m^2
    :force                    => "mass*accelleration",              # => m*kg/s^2
      :weight                 => "force",
    :pressure                 => "force/area",                      # => N/m^2
      :stress                 => "pressure",
    :energy                   => "force*distance",                  # => N*m
      :work                   => "energy",
      :heat                   => "energy",
    :electric_field_strength  => "force/charge",                    # => N/C or voltage/distance (V/m)
    :power                    => "energy/duration",                 # => J/s or voltage*current (V*A)
      :radiant_flux           => "power",
    :charge                   => "duration*current",                # => s*A
      :electrical_charge      => "charge",
      :electrical_flux        => "charge",
    :voltage                  => "energy/charge",                   # => W/A or energy/charge (J/C)
      :electrical_potential_difference => "voltage",
      :electromotive_force    => "voltage",
    :capacitance              => "charge/voltage",                  # => C/V
      :electrical_capacitance => "capacitance",
    :resistance               => "voltage/current",                 # => V/A
      :electric_resistance    => "resistance",
      :impedance              => "resistance",
      :reactance              => "resistance",
    :conductance              => "resistance^-1",                   # => 1/Ω
      :electrical_conductance => "conductance",
    :magnetic_flux            => "energy/current",                  # => J/A
    :magnetic_field           => "voltage*duration/area",           # => V*s/m^2 = Wb/m^2 = N/(A*m)
    :inductance               => "voltage*duration/current",        # => V*s/A = Wb/A
    :luminous_flux            => "luminous_intensity*solid_angle",  # => cd*sr
    :illuminance              => "luminous_flux/area",              # => lm/m^2
    :radioactivity            => "duration^-1",                     # => 1/s
    :absorbed_dose            => "energy/mass",                     # => J/kg
    :equivalent_dose          => "energy/mass",                     # => J/kg
    :catalytic_activity       => "mole/duration",                   # => mol/s
    :velocity                 => "distance/duration",               # => m/s
      :speed                  => "velocity",
    :acceleration             => "distance/duration^2",             # => m/s^2
    :jerk                     => "distance/duration^3",             # => m/s^3
      :jolt                   => "jerk",
    :snap                     => "distance/duration^4",             # => m/s^4
    :crackle                  => "distance/duration^5",             # => m/s^5
    :pop                      => "distance/duration^6",             # => m/s^6
    :area                     => "distance^2",                      # => m^2
    :volume                   => "distance^3",                      # => m^3
    :volumetric_flow          => "volume/duration",                 # => m^3/s
    :angular_velocity         => "angle/duration",                  # => rad/s
    :momentum                 => "force*duration",                  # => 
      :impulse                => "momentum",
    :angular_momentum         => "force*distance*duration",         # => 
    :torque                   => "force*distance",                  # => 
      :moment_of_force        => "torque",
    :density                  => "mass/volume",                     # => 
      :mass_density           => "density",
    :wave_number              => "distance^-1",                     # => 
    :specific_volume          => "distance^3/mass",                 # => 
    :molarity                 => "mole/volume",                     # => 
      :molar_concentration    => "molarity",
    :molar_volume             => "volume/mole",                     # => 
    :heat_capacity            => "energy/temperature",              # => 
      :entropy                => "heat_capacity",
    :molar_heat_capacity      => "energy/temperature/mole",         # => 
      :molar_entropy          => "molar_heat_capacity",
    :specific_heat_capacity   => "energy/temperature/mass",         # => 
      :specific_entropy       => "specific_heat_capacity",
    :molar_energy             => "energy/mole",                     # => 
    :specific_energy          => "energy/mass",                     # => 
    :energy_density           => "energy/volume",                   # => 
    :surface_tension          => "force/distance",                  # => 
    :irradiance               => "power/area",                      # => 
      :heat_flux_density      => "irradiance",
    :thermal_conductivity     => "power/distance/temperature",      # => 
    :kinematic_viscosity      => "area/duration",                   # => 
      :diffusion_coefficient  => "kinematic_viscosity",
    :dynamic_viscosity        => "pressure*duration",               # => 
    :electric_charge_density  => "charge/volume",                   # => 
    :electric_current_density => "current/volume",                  # => 
    :conductivity             => "conductance/distance",            # => 
    :molar_conductivity       => "conductance*area/mole",           # => 
    :permittivity             => "capacitance/distance",            # => 
    :permeability             => "inductance/distance",             # => 
    :electric_field_strength  => "voltage/distance",                # => 
    :magnetic_field_strength  => "current/distance",                # => 
    :luminance                => "luminous_intensity/area",         # => 
    :ray_exposure             => "charge/mass",                     # => 
    :absorbed_dose_rate       => "absorbed_dose/duration",          # => 
    :resistivity              => "resistance/distance"              # => 
  }

  class Measure
    # override these for concrete classes
    @@unit          = "unitless"
    @@quantity      = "quantity"
    @@unit_aliases = {:abbreviation => "", :alternates => []}

    def initialize(value,modifier="base",unit=@@unit,quantity=@@quantity)
      raise ArgumentError, "value has to be a Numeric type (Integer,Float,Fixnum,Bignum). Really now, what'd you think it should be?" unless value.kind_of? Numeric
      raise ArgumentError, "Unit modifier must be 'base' or one of #{Measures::PREFIX_FULL.keys.compact.join(", ")}" unless Measures::PREFIX_FULL.keys.include? modifier
    
      @value =    value.to_f
      @modifier = modifier  # TODO => should be combined into the unit info. (maybe?)
      @unit =     unit      # unit is the actual unit definition.  e.g. m/s^2
      @quantity = quantity  # quantity is the definition of what the measure is a measurement of e.g. acceleration
    end

  # ======================================
  # Info & Reporting Methods
  # ======================================
    attr_reader :value, :unit, :quantity, :modifier
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
      unless self.compatible? obj
        raise ArgumentError, "first argument (#{self}) must be compatible with second argument (#{obj}) in order to compare them."
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
    # return value is given in the unit of the first operand
    def unit_arithmetic(operator,second_operand)
      raise ArgumentError, "operator has to be '+' or '-'" unless ["+","-"].include? operator
      unless self.compatible? second_operand
        raise ArgumentError, "first operand (#{self}) must be compatible with second operand (#{second_operand}) in order to perform #{operator}."
      end
    
      first_value = self.convert_to("base").value
      second_value = second_operand.convert_to(self.unit)
      result = first_value.send(operator,second_value)
      return self.class.new(result,self.unit)
    end
  
    def +(addend)
      unit_arithmetic("+",addend)
    end
  
    def -(subtractor)
      unit_arithmetic("-",subtractor)
    end
  
    # A measure can be multiplied by either a Numeric scaling factor OR
    # by another measure type.  In the former case, the class remains the same
    # in the latter case, a new ComplexMeasure is returned, with a new unit.
    def *(multiplier)
      if multiplier.kind_of? Measures::Measure
        value     = self.value * multiplier.value
        unit      = "#{self.unit}*#{multiplier.unit}"
        modifier  = "base"
        quantity  = "#{self.quantity}*#{multiplier.quantity}"
        result    = ComplexMeasure.new(value,modifier,unit,quantity)
      elsif multiplier.is_a? Numeric
        value     = self.value * multiplier
        unit      = self.unit
        modifier  = self.modifier
        quantity  = self.quantity
        result    = self.class.new(value,modifier,unit,quantity)
      else
        raise ArgumentError, "multiplier must be either a Numeric or a Measure of some sort (BaseMeasure or ComplexMeasure)"
      end
      return result
    end
  
    # A measure can be divided by either a Numeric scaling factor OR
    # by another measure type.  In the former case, the class remains the same
    # in the latter case, a new ComplexMeasure is returned, with a new unit.
    def /(divisor)
      if divisor.kind_of? Measures::Measure
        value     = self.value / divisor.value
        unit      = "#{self.unit}/#{divisor.unit}"
        modifier  = "base"
        quantity  = "#{self.quantity}/#{divisor.quantity}"
        result    = ComplexMeasure.new(value,modifier,unit,quantity)
      elsif divisor.is_a? Numeric
        value     = self.value / divisor
        unit      = self.unit
        modifier  = self.modifier
        quantity  = self.quantity
        result    = self.class.new(value,modifier,unit,quantity)
      else
        raise ArgumentError, "divisor must be either a Numeric or a Measure of some sort (BaseMeasure or ComplexMeasure)"
      end
      return result
    end

  # ======================================
  # Casting & Conversion Methods
  # ======================================  
    def convert_to(target)
      raise NoMethodError, "this method should have been overridden in either BaseMeasure or ComplexMeasure"
    end
  
  end

  class BaseMeasure < Measure
    # override these for concrete classes
    # @@quantity      = "quantity"
    # @@unit_aliases = {:abbreviation => "", :alternates => []}    
    # UNIT IS AUTOMATICALLY DEFINED BY SUBCLASS'S NAME (see self.inherited(subclass))
    # @@unit          = "unit" 

    
    def convert_to(target)
      si_convert_to(target)
    end
    
    def si_convert_to(new_modifier)
      raise ArgumentError, "New unit modifier must be a valid SI prefix (#{Measures::PREFIX_FULL.keys.compact.join(",")})" unless Measures::PREFIX_FULL.keys.include? new_modifier
      modifier_order_of_magnitude = Measures::PREFIX_FULL[@modifier]
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
            convert_to("#{modifier}#{@@unit}")
          end
        evalblock
      end
    end
  end

  class ComplexMeasure < Measure
    # override these for concrete classes
    # @@unit_aliases = {:abbreviation => "", :alternates => []}
    # @@quantity      = "quantity"
    # @@unit_aliases  = []
    
    # ToDo: need a recursive descent parser to validate and
    # expand units into expressions derived from basic units.

    def convert_to(target)
      
    end
  end

end
=begin
  Tokens:
    unit_abbreviation       = very very long but arbitrary/pluginable list
    scale_abbreviation      = ["k", "a", "M", "m", "Y", "c", "n", "y", "Z", "d", "z", "E", "P", "p", "f", "G", "da", "μ", "h", "T"]
    multiplication_operator = "*"
    division_operator       = "/"
    power_operator          = "^"
    negation_operator       = "-"
    digit                   = [0-9]
    power                   = negation_operator? + digit+
    operator                = [multiplication_operator,division_operator]
    
  Structures:
    scale_unit              = scale_abbreviation + unit_abbreviation
    scale_power_unit        = scale_unit + power_operator + power
    
    
  Transformations:
    division_as_power       = scale_power_unit + division_operator + scale_power_unit => 
                              scale_power_unit + multiplication_operator + inverted_scale_power_unit
                              
  m*kg/s^2
  (m * (k g)) / (s ^ 2)
=end


=begin
$:.unshift(File.dirname(__FILE__)+'/lib')
require 'measures'
class Metre < Measures::BaseMeasure
  @@unit = "Metre"
  @@quantity = "distance"
  @@unit_aliases = ["meter", "m"]
end
Metre.new(4,"kilo").centimetres
Metre.new(4,"kilo") == Metre.new(4000)
=end
