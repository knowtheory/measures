Measures is, oddly enough, a measurement library.

It is currently pre-alpha, but available for people to look at.

My goal for measures is type checking for measurement units, and safe accurate conversion between them.  The initial seed target is the System International (metric), but my own needs will require US Customary Units (us imperial) eventually.  In the end, the library will contain wrapper classes for Datamapper (and hopeful ActiveRecord), to let users store measurements with validations and automatic coercion.

# Sample goals

>> 4.kilometres # => returns a Metre object w/ value 4 kilometres

>> 4.kilometres.convert_to("meters") # => returns a Metre object w/ value 4000 metres

>> 4.kilometres.convert_to("meters") / 20.seconds # => returns a ComplexMeasure object w/ value 200 metres per second

# Gotchas

Some of the classes require functioning Unicode support.  If you're on OSX you'll need to monkey around with the default ruby installation a bit as per http://henrik.nyh.se/2008/03/irb-readline

Thanks To:

Massive thanks to Luke Sutton ( http://mr-eel.com/ ) for serving as a sounding board for ideas, and providing suggestions.