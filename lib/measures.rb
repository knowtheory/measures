$KCODE = "UTF8" if $KCODE == "NONE"

$:.push File.dirname(__FILE__) + "/measures/"

require 'base'
require 'ministry_of_weights_and_measures'
require 'common_measures'
require 'modifiers/named_quantities'