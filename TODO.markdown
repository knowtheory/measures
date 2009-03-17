# Outstanding
## Conversion between measurement systems
### Issue
The Ministry of Weights and Measures should be able to tell us that 1 inch == 2.54 centimeters.  More over it should be able to also tell us that 1 smoot = 67 inches.  Need to decide if this is point to point, or whether the metric system 

## Build solver to reduce/simplify equations.
the following should be determined to be equal:
"((metre\*gram/second^2)\*metre)"
"(second\*ampere)/((((metre\*gram/second^2)\*metre)/second)/ampere)"

## Solve abbreviation ambiguity
### Issue
5.m.m should equal 5.milli.metres.  Problem is that 5.m could be 5.metres or 5.milli

## Factor all definitions into a form consistent with the Buckingham π theorem.
### Issue
Need a reduced form for all measure definitions.  The Buckingham π form seems to be the standard format for it.  Need to still account for some issues like "celcius/seconds" should reduce to "(kelvin+273)/seconds", and then to "(kelvin*seconds^-1) + (273/seconds)"

## Coping with significant figures and floating point precision problems.
### Issue
The internal representations of measures are going to have to deal with [floating point precision issues] (http://en.wikipedia.org/wiki/Floating_point#Accuracy_problems), particularly since a lot of the lib functions off of actual multiplication of values.
### Solution Ideas
* Let people specify whether to run in BigDecimal or normal Float mode.
* Let people specify significant figures of a value of a measure.

# Completed
## DONE 02/27/09: Definitional Ambiguity Dealt with
Done by forcing additional tokens :P so kilograms must be represented as "kilo.gram" or "k.g"
### Issue
Unfortunately there was an irresolvable ambiguity problem for certain tokens.  There's no way to tell if "metre" is a milli-etre, or just a metre.