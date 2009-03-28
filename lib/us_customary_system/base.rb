module USCustomarySystem
  # ======================================
  # Distance
  # ======================================
  class Inch < Measures::Measure
    defined_as "distance"
    abbreviated_as "in"
  end
  
  class Foot
    defined_as "distance", "12*in"
    abbreviated_as "ft"
  end
  
  class Yard
    defined_as "distance", "3*ft"
    abbreviated_as "yd"
  end
  
  class Mile
    defined_as "distance", "5280*ft"
  end
  
  # ======================================
  # Spatial Volume
  # ======================================
  class CubicInch
    defined_as "volume", "in^3"
  end
  
  class CubicFoot
    defined_as "volume", "ft^3"
  end
  
  class CubicYard
    defined_as "volume", "yd^3"
  end
  
  # ======================================
  # Fluid Volume
  # ======================================
  class Minim
    defined_as "fluid_volume"
    abbreviated_as "flmin"
  end
  
  class FluidDram
    defined_as "fluid_volume", "60*flmin"
    abbreviated_as "fldr"
  end
  
  class FluidOunce
    defined_as "fluid_volume", "8*fldr"
    abbreviated_as "floz"
  end
  
  class Gill
    defined_as "fluid_volume", "4*floz"
    abbreviated_as "gi"
  end
  
  class Cup
    defined_as "fluid_volume", "8*floz"
    abbreviated_as "cp"
  end
  
  class Pint
    defined_as "fluid_volume", "16*floz"
    abbreviated_as "pt"
  end
  
  class Quart
    defined_as "fluid_volume", "32*floz"
    abbreviated_as "qt"
  end
  
  class Gallon
    defined_as "fluid_volume", "128*floz"
    abbreviated_as "gal"
  end
  
  class BeerBarrel
    defined_as "fluid_volume", "31*gal"
    abbreviated_as "bbl"
  end
  
  class OilBarrel
    defined_as "fluid_volume", "42*gal"
    abbreviated_as "bbl"
  end
  
  class Hogshead
    defined_as "fluid_volume", "63*gal"
  end
  
  #
  # Cooking Measures
  # 
  class Tablespoon
    defined_as "fluid_volume", "floz/2"
    abbreviated_as "tbsp"
  end
  
  class Teaspoon
    defined_as "fluid_volume", "tbsp/3"
    abbreviated_as "tsp"
  end
  
  class Dash
    defined_as "fluid_volume", "tsp/8"
    abbreviated_as "ds"
  end
  
  class Drop
    defined_as "fluid_volume", "tsp/96"
  end

  # ======================================
  # Dry volume
  # ======================================
  class DryPint
    defined_as "dry_volume"
    abbreviated_as "dpt"
  end
  
  class DryQuart
    defined_as "dry_volume", "2*dpt"
    abbreviated_as "dqt"
  end
  
  class DryGallon
    defined_as "dry_volume", "4*dqt"
    abbreviated_as "dgal"
  end
  
  class Peck
    defined_as "dry_volume", "2*dgal"
    abbreviated_as "pk"
  end
  
  class Buschel
    defined_as "dry_volume", "4*pk"
    abbreviated_as "bu"
  end
  
  # ======================================
  # Mass
  # ======================================
  module Avoirdupois
    class Grain < Measures::Measure
      defined_as "mass"
      abbreviated_as "gr"
    end
    
    class Dram < Measures::Measure
      defined_as "mass", "22*11/32*gr"
    end
      
    class Ounce < Measures::Measure
      defined_as "mass", "16*dr"
    end

    class Pound < Measures::Measure
      defined_as "mass", "7000*gr"
      abbreviated_as "lb"
    end
    
    class Hundredweight < Measures::Measure
      defined_as "mass", "100*lb"
      abbreviated_as "cwt"
    end

    class Ton < Measures::Measure
      defined_as "mass", "20*cwt"
    end
  end
end