class Hertz < Measure::ComplexMeasure
  @@quantity      = "frequency"
  @@unit          = "s^-1"
  @@unit_alias    = {:abbreviation => "Hz"}
end

class Radian < Measure::ComplexMeasure
  @@quantity      = "angle"
  @@unit          = "m/m" # m/m
  @@unit_alias    = {:abbreviation => "rad"}
end

class Steradian < Measure::ComplexMeasure
  @@quantity      = "solid_angle"
  @@unit          = "m^2/m^2" # m^2/m^2?
  @@unit_alias    = {:abbreviation => "sr"}
end

class Newton < Measure::ComplexMeasure
  @@quantity      = "force"
  @@unit          = "m*kg/s^2"
  @@unit_alias    = {:abbreviation => "N", :aliases => []}  
end

class Pascal < Measure::ComplexMeasure
  @@quantity      = "pressure"
  @@unit          = "N/m^2"
  @@unit_alias    = {:abbreviation => "Pa", :aliases => []}
end

class Joule < Measure::ComplexMeasure
  @@quantity      = "energy"
  @@unit          = "N*m"
  @@unit_alias    = {:abbreviation => "J", :aliases => []}
end

class Watt < Measure::ComplexMeasure
  @@quantity      = "power"
  @@unit          = "J/s"
  @@unit_alias    = {:abbreviation => "W", :aliases => []}
end

class Coulomb < Measure::ComplexMeasure
  @@quantity      = "charge"
  @@unit          = "s*A"
  @@unit_alias    = {:abbreviation => "C", :aliases => []}
end

class Volt < Measure::ComplexMeasure
  @@quantity      = "voltage"
  @@unit          = "W/A"
  @@unit_alias    = {:abbreviation => "V", :aliases => []}
end

class Farad < Measure::ComplexMeasure
  @@quantity      = "capacitance"
  @@unit          = "C/V"
  @@unit_alias    = {:abbreviation => "F", :aliases => []}
end

class Ohm < Measure::ComplexMeasure
  @@quantity      = "resistance"
  @@unit          = "V/A"
  @@unit_alias    = {:abbreviation => "Ω", :aliases => []}
end

class Siemens < Measure::ComplexMeasure
  @@quantity      = "conductance"
  @@unit          = "Ω^-1"
  @@unit_alias    = {:abbreviation => "S", :aliases => []}
end

class Weber < Measure::ComplexMeasure
  @@quantity      = "magnetic_flux"
  @@unit          = "J/A"
  @@unit_alias    = {:abbreviation => "Wb", :aliases => []}
end

class Tesla < Measure::ComplexMeasure
  @@quantity      = "inductance"
  @@unit          = "V*s/m^2"
  @@unit_alias    = {:abbreviation => "T", :aliases => []}
end

class Henry < Measure::ComplexMeasure
  @@quantity      = "inductance"
  @@unit          = "V*s/A"
  @@unit_alias    = {:abbreviation => "H", :aliases => []}
end

class Celcius < Measure::ComplexMeasure
  @@quantity      = "temperature"
  @@unit          = "K - 273.15"
  @@unit_alias    = {:abbreviation => "C", :aliases => ["centigrade"]}
end

class Lumen < Measure::ComplexMeasure
  @@quantity      = "luminous_flux"
  @@unit          = "cd*sr"
  @@unit_alias    = {:abbreviation => "lm", :aliases => []}
end

class Lux < Measure::ComplexMeasure
  @@quantity      = "illuminance"
  @@unit          = "lm/m^2"
  @@unit_alias    = {:abbreviation => "lx", :aliases => []}
end

class Becquerel < Measure::ComplexMeasure
  @@quantity      = "radioactivity"
  @@unit          = "s^-1"
  @@unit_alias    = {:abbreviation => "Bq", :aliases => []}
end

class Gray < Measure::ComplexMeasure
  @@quantity      = "absorbed_dose"
  @@unit          = "J/kg"
  @@unit_alias    = {:abbreviation => "Gy", :aliases => []}
end

class Sievert < Measure::ComplexMeasure
  @@quantity      = "equivalent_dose"
  @@unit          = "J/kg"
  @@unit_alias    = {:abbreviation => "Sv", :aliases => []}
end

class Katal < Measure::ComplexMeasure
  @@quantity      = "catalytic_activity"
  @@unit          = "mol/s"
  @@unit_alias    = {:abbreviation => "kat", :aliases => []}
end

class Litre < Measure::ComplexMeasure
  @@quantity      = "volume"
  @@unit          = "dm^3"
  @@unit_alias    = {:abbreviation => "l", :aliases => ["liter"]}
end

=begin
class < Measure::ComplexMeasure
  @@quantity      = ""
  @@unit          = ""
  @@unit_alias    = {:abbreviation => "", :aliases => []}
end
=end


module InternationalSystem
  DERIVED_MEASURES = {
    :frequency                => Hertz,
    :angle                    => Radian,
    :solid_angle              => Steradian,
    :force                    => Newton,
    :pressure                 => Pascal,
    :energy                   => Joule,
#    :electric_field_strength  => ,
    :power                    => Watt,
    :charge                   => Coulomb,
    :voltage                  => Volt,
    :capacitance              => Farad,
    :resistance               => Farad,
    :conductance              => Siemens,
    :magnetic_flux            => Weber,
    :magnetic_field           => Tesla,
    :inductance               => Henry,
    :luminous_flux            => Lumen,
    :illuminance              => Lux,
    :radioactivity            => Becquerel,
    :absorbed_dose            => Gray,
    :equivalent_dose          => Sievert,
    :catalytic_activity       => Katal,
    :volume                   => Litre#,
=begin
    :velocity                 => ,
    :acceleration             => ,
    :jerk                     => ,
    :snap                     => ,
    :crackle                  => ,
    :pop                      => ,
    :area                     => ,
    :volumetric_flow          => ,
    :angular_velocity         => ,
    :momentum                 => ,
    :angular_momentum         => ,
    :torque                   => ,
    :density                  => ,
    :wave_number              => ,
    :specific_volume          => ,
    :molarity                 => ,
    :molar_volume             => ,
    :heat_capacity            => ,
    :molar_heat_capacity      => ,
    :specific_heat_capacity   => ,
    :molar_energy             => ,
    :specific_energy          => ,
    :energy_density           => ,
    :surface_tension          => ,
    :irradiance               => ,
    :thermal_conductivity     => ,
    :kinematic_viscosity      => ,
    :dynamic_viscosity        => ,
    :electric_charge_density  => ,
    :electric_current_density => ,
    :conductivity             => ,
    :molar_conductivity       => ,
    :permittivity             => ,
    :permeability             => ,
    :electric_field_strength  => ,
    :magnetic_field_strength  => ,
    :luminance                => ,
    :ray_exposure             => ,
    :absorbed_dose_rate       => ,
    :resistivity              => 
=end
  }
end
