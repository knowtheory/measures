#
# This class is an abstract class for proxy objects used by measures.
#
# Each subclass, when defined using the set class method is registered
# with the MinistryOfWeightsAndMeasures.  The Ministry in turn adds a class
# method to the parent NamedQuantity for each registered Measure object.
# Thus each NamedQuantity is able to spawn a class w/ the relevant quantity
# predefined.
# 
# Example:
# Kilo.meter == Meter.new(1000)
# Kilo.meter == Meter.new(1,"km")
class NamedQuantity # abstract class
  class << self 
    attr_reader :modifier, :base, :exponent, :abbreviation
    alias abbr abbreviation
  end

  # This method 
  #
  # "abbreviation" can either be a string or an array.
  # "base" should be a positive non-zero number, but i'm not going to stop you if you do something weird.
  # "exponent" should be self explanatory :P
  def self.set(abbreviation, base, exponent=1)
    self.instance_variable_set("@modifier", (base ** exponent))
    self.instance_variable_set("@base", base )
    self.instance_variable_set("@exponent", exponent )
    self.instance_variable_set("@abbreviation", abbreviation )
    
    MinistryOfWeightsAndMeasures.register_modifier(self, self.abbreviation)
  end
  
  attr_reader :value
  def initialize(value)
    @value = value.to_f
  end
  
  def to_s
    (@value * self.class.modifier).to_s
  end
end

class Yocto   < NamedQuantity; set("y", 10, -24);  end
class Zepto   < NamedQuantity; set("z", 10, -21);  end
class Atto    < NamedQuantity; set("a", 10, -18);  end
class Fempto  < NamedQuantity; set("f", 10, -15);  end
class Pico    < NamedQuantity; set("p", 10, -12);  end
class Nano    < NamedQuantity; set("n", 10, -9);   end
class Micro   < NamedQuantity; set("μ", 10, -6);   end
class Milli   < NamedQuantity; set("m", 10, -3);   end
class Centi   < NamedQuantity; set("c", 10, -2);   end
class Deci    < NamedQuantity; set("d", 10, -1);   end
class Deca    < NamedQuantity; set("da", 10, 1);   end
class Hecto   < NamedQuantity; set("h", 10, 2);    end
class Kilo    < NamedQuantity; set("k", 10, 3);    end
class Mega    < NamedQuantity; set("M", 10, 6);    end
class Giga    < NamedQuantity; set("G", 10, 9);    end
class Tera    < NamedQuantity; set("T", 10, 12);   end
class Peta    < NamedQuantity; set("P", 10, 15);   end
class Exo     < NamedQuantity; set("E", 10, 18);   end
class Zetta   < NamedQuantity; set("Z", 10, 21);   end
class Yotta   < NamedQuantity; set("Y", 10, 24);   end