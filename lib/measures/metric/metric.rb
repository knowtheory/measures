require 'common_measures'
require 'modifiers/named_quantities'
require 'metric/base'
require 'metric/derived'

module Metric
  MEASURES = {
    # base SI measures
    :distance           => "Metre",
    :mass               => "Gram",
    :time               => "Second",
    :current            => "Ampere",
    :quantity           => "Mole",
    :luminous_intensity => "Candela",
    
    # compound SI measures
    :area               => "Square Metre",
    :volume             => "Cubic Metre",
    :velocity           => "Metre per Second",
    :acceleration       => "Metre per Second Squared",
    :volumetric_flow    => "Cubic Metre per Second",

    # derived SI measures
    :angle              => "Radian",
    :frequency          => "Hertz",
    :weight             => "Newton",
    :temperature        => "Celsius",
    :pressure           => "Pascal",

    :energy             => "Joule",
    :power              => "Watt",
    :voltage            => "Volt",
    :capacitance        => "Farad",
    :resistance         => "Ohm",
    :conductance        => "Siemens",
    :inductance         => "Henry",
    :magnetic_flux      => "Weber",
    :magnetic_field     => "Tesla",

    :luminous_flux      => "Lumen",
    :illuminance        => "Lux",
 
    :radioactivity      => "Becquerel",
    :absorbed_dose      => "Gray",
    :equivalent_dose    => "Sievert",
 
    :catalitic_activity => "Katal"
  }

  MEASURES_ABBREVIATED = {
    # base SI measures
    :distance           => "m",
    :mass               => "g",
    :time               => "s",
    :current            => "A",
    :quantity           => "mol",
    :luminous_intensity => "cd",

    # derived SI measures
    :angle              => "rad",
    :frequency          => "Hz",
    :weight             => "N",
    :temperature        => "°C",
    :pressure           => "Pa",

    :energy             => "J",
    :power              => "W",
    :voltage            => "V",
    :capacitance        => "F",
    :resistance         => "Ω",
    :conductance        => "S",
    :inductance         => "H",
    :magnetic_flux      => "Wb",
    :magnetic_field     => "T",

    :luminous_flux      => "lm",
    :illuminance        => "lx",
 
    :radioactivity      => "Bq",
    :absorbed_dose      => "Gy",
    :equivalent_dose    => "Sv",
 
    :catalitic_activity => "kat"
  }
  
end