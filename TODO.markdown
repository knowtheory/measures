# Outstanding
## Conversion between measurement systems
### Issue
The Ministry of Weights and Measures should be able to tell us that 1 inch == 2.54 centimeters.  More over it should be able to also tell us that 1 smoot = 67 inches.  Need to decide if this is point to point, or whether the metric system 

## Build solver to reduce/simplify equations.
the following should be determined to be equal:
"((metre\*gram/second^2)\*metre)"
"(second\*ampere)/((((metre\*gram/second^2)\*metre)/second)/ampere)"

## Solve abbreviation ambiguity
### iSsue
5.m.m should equal 5.milli.metres.  Problem is that 5.m could be 5.metres or 5.milli

# Completed
## DONE 02/27/09: Definitional Ambiguity Dealt with
Done by forcing additional tokens :P so kilograms must be represented as "kilo.gram" or "k.g"
### Issue
Unfortunately there was an irresolvable ambiguity problem for certain tokens.  There's no way to tell if "metre" is a milli-etre, or just a metre.