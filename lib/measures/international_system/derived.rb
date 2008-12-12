module InternationalSystem

  class Hertz < Measure::ComplexMeasure
    defined_as "frequency", "s^-1"
    abbreviated_as "Hz"
  end

  class Radian < Measure::ComplexMeasure
    defined_as "angle", "m/m" # m/m
    abbreviated_as "rad"
  end

  class Steradian < Measure::ComplexMeasure
    defined_as "solid_angle", "m^2/m^2" # m^2/m^2?
    abbreviated_as "sr"
  end

  class Newton < Measure::ComplexMeasure
    defined_as "force", "m*kg/s^2"
    abbreviated_as "N"  
  end

  class Pascal < Measure::ComplexMeasure
    defined_as "pressure", "N/m^2"
    abbreviated_as "Pa"
  end

  class Joule < Measure::ComplexMeasure
    defined_as "energy", "N*m"
    abbreviated_as "J"
  end

  class Watt < Measure::ComplexMeasure
    defined_as "power", "J/s"
    abbreviated_as "W"
  end

  class Coulomb < Measure::ComplexMeasure
    defined_as "charge", "s*A"
    abbreviated_as "C"
  end

  class Volt < Measure::ComplexMeasure
    defined_as "voltage", "W/A"
    abbreviated_as "V"
  end

  class Farad < Measure::ComplexMeasure
    defined_as "capacitance", "C/V"
    abbreviated_as "F"
  end

  class Ohm < Measure::ComplexMeasure
    defined_as "resistance", "V/A"
    abbreviated_as "Ω"
  end

  class Siemens < Measure::ComplexMeasure
    defined_as "conductance", "Ω^-1"
    abbreviated_as "S"
  end

  class Weber < Measure::ComplexMeasure
    defined_as "magnetic_flux", "J/A"
    abbreviated_as "Wb"
  end

  class Tesla < Measure::ComplexMeasure
    defined_as "inductance", "V*s/m^2"
    abbreviated_as "T"
  end

  class Henry < Measure::ComplexMeasure
    defined_as "inductance", "V*s/A"
    abbreviated_as "H"
  end

  class Celcius < Measure::ComplexMeasure
    defined_as "temperature", "K - 273.15"
    @@unit_alias    = {:abbreviation => "C", :aliases => ["centigrade"]}
  end

  class Lumen < Measure::ComplexMeasure
    defined_as "luminous_flux", "cd*sr"
    abbreviated_as "lm"
  end

  class Lux < Measure::ComplexMeasure
    defined_as "illuminance", "lm/m^2"
    abbreviated_as "lx"
  end

  class Becquerel < Measure::ComplexMeasure
    defined_as "radioactivity", "s^-1"
    abbreviated_as "Bq"
  end

  class Gray < Measure::ComplexMeasure
    defined_as "absorbed_dose", "J/kg"
    abbreviated_as "Gy"
  end

  class Sievert < Measure::ComplexMeasure
    defined_as "equivalent_dose", "J/kg"
    abbreviated_as "Sv"
  end

  class Katal < Measure::ComplexMeasure
    defined_as "catalytic_activity", "mol/s"
    abbreviated_as "kat"
  end

  class Litre < Measure::ComplexMeasure
    defined_as "volume", "dm^3"
    abbreviated_as "l"
    aka "liter"
  end

=begin
class < Measure::ComplexMeasure
  @@quantity      = ""
  @@unit          = ""
  @@unit_alias    = {:abbreviation => "", :aliases => []}
end
=end


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
    :volumetric_flow          => m^3/s,
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
