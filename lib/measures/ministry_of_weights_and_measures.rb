#require 'lib/measures'; require 'metric/metric'
require 'english/inflect'
require 'singleton'
require 'treetop'
require 'definition/definition'
Treetop.load File.expand_path("./lib/measures/definition/definition")

# # if you don't like the class name, just subclass it, or alias it to something else :)
# i've already stuck it in Ministry for my convenience
class MinistryOfWeightsAndMeasures
  include Singleton
  
  @@measure_map = 
  { # measure of              # description/derivation              # unit derivation in SI
    :frequency                => "duration^-1",                     # => 1/s
    :angle                    => "distance/distance",               # => m/m
    :solid_angle              => "area/area",                       # => m^2/m^2
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
    :molar_mass               => "mass/mole",
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
  
  @@parser                = DefinitionParser.new
  @@measures              = {} # list of measures
  @@quantities            = {} # quantity     => class
  @@abbreviations         = {} # abbreviation => class
  @@prefixes              = {}
  @@prefix_abbreviations  = {}
  
=begin
  @@measure_names_regexp      = Regexp.new(@@measures.keys.compact.join("|"))
  @@measure_abbr_regexp       = Regexp.new(@@abbreviations[:measures].keys.compact.join("|"))
  @@prefix_full_regexp        = Regexp.new(@@prefixes.keys.compact.join("|"))
  @@prefix_abbr_regexp        = Regexp.new(@@abbreviations[:prefixes].keys.compact.join("|"))

  @@prefix_full_regexp        = Regexp.new(Measures::PREFIX_FULL.keys.compact.join("|"))
  @@prefix_abbreviated_regexp = Regexp.new(Measures::PREFIX_ABBREVIATED.keys.compact.join("|"))
=end  

  def self.tokens
    @@tokens ||= []
  end
  
  def self.clear_tokens!
    @@tokens = []
  end
  
  def self.conversion_factor(current, destination)
    
  end

  # put in a complex definition and get out a definition in terms
  # of the base units for a measurement system.
  def self.factor(definition)
    self.clear_tokens!
    tree = self.parse(definition) # get tree, and provide tokens
#    puts "Factoring Definition"
    result = self.tokens.map do |token|
#      puts "TOKEN #{token}"
      if token =~ /^([A-Za-z]+\.)?[A-Za-z]+$/
        prefix, identifier = Ministry.tokenize_measure(token)
        klass = self.identify(identifier)
        unless klass
          self.clear_tokens!
          raise StandardError, "Could not identify a measure for '#{token}'"
        end
        definition = klass.factored_definition
        if definition =~ /^([A-Za-z]+\.)?[A-Za-z]+$/
          definition
        else
          "(#{definition})"
        end
      else
        token
      end
    end.join
    self.clear_tokens!
    return result
  end

  
    # put in a definition, ensures that:
    #   all the units in the definition are valid
    #   the definition parses properly
    def self.validate(definition)
      result = (not self.parse(definition).nil?)
      self.clear_tokens!
      return result
    end
  
    def self.parse(definition)
      @@parser.parse(definition)
    end
  
  def self.tokenize_measure(measure)
    if measure =~ /^[A-Za-z]+\.[A-Za-z]+$/
      prefix, identifier = measure.split(".")
    elsif measure =~ /^[A-Za-z]+$/
      prefix = ""
      identifier = measure
    else
      puts "WARNING #{measure} is not a valid measure"
    end
    return [prefix,identifier]
  end
  
  def self.identify(measure)
    prefix, identifier = Ministry.tokenize_measure(measure)
#    puts "Prefix (#{prefix}), and measure (#{identifier})"
    if @@abbreviations.include? identifier
      result = @@abbreviations[identifier]
    elsif @@measures.include? identifier
      result = @@measures[identifier]
    else
      puts "WARNING '#{measure}' could not be identified"
      result = nil
    end
    return result
  end
  
  def self.register_measure(klass,quantity,definition)
    @@measures[klass.to_s.split("::").last.downcase] = klass
    @@quantities[quantity] ||= []
    @@quantities[quantity] << klass
    self.add_methods_to_core_for(klass)
  end
  
  def self.register_measure_abbreviation(klass,abbreviation)
    message =  "#{abbreviation} is already being used, and can't be set as the abbreviation for #{klass.to_s}"
    raise ArgumentError, message if @@abbreviations.keys.include? abbreviation
    @@abbreviations[abbreviation] = klass
    self.add_abbreviation_alias_to_core_for(klass,abbreviation)
  end
  
  def self.register_modifier(klass,abbreviation)
    name = klass.to_s.split("::").last.downcase
    @@prefixes[name] = klass
    message =  "#{abbreviation} is already being used, and can't be set as the abbreviation for #{name}"
    raise ArgumentError, message if @@abbreviations.keys.include? abbreviation
    @@prefix_abbreviations[abbreviation] = klass
  end
  
  def self.abbreviations
    @@abbreviations
  end
  
  def self.equivalent?(def1,def2)
    self.factor(def1) == self.factor(def2)
  end

  def self.add_methods_to_core_for(klass,options={})
    raise ArgumentError, "you must supply a valid measure class" unless klass.kind_of? Class
    class_name = klass.to_s
    class_abbreviation = klass.abbreviation
    if options[:namespaced]
      method_name = class_name.split("::").join("_").downcase
    else
      method_name = class_name.split("::").last.downcase
    end
    Numeric.class_eval <<-eval_block
      def #{method_name}
        #{class_name}.new(self)
      end
      alias_method "#{method_name.pluralize}".to_sym, "#{method_name}".to_sym
    eval_block
  end
  
  def self.add_abbreviation_alias_to_core_for(klass, abbreviation,options={})
    class_name = klass.to_s
    if options[:namespaced]
      method_name = class_name.split("::").join("_").downcase
    else
      method_name = class_name.split("::").last.downcase
    end
    Numeric.class_eval <<-eval_block
      alias_method "#{abbreviation}".to_sym, "#{method_name}".to_sym
    eval_block
  end
  
  def self.remove_methods_from_core_for(klass)
  end
  
  def self.reset!
    @@measures                  = {}
    @@quantities                = {}
    @@abbreviations             = {} # abbreviation => class
  end
end

unless Object.const_defined?(:Registry) and Object.const_defined?(:Ministry)
  Registry = Ministry = MinistryOfWeightsAndMeasures
end
