require 'treetop'

module Definition
  include Treetop::Runtime
  
  class ParenNode < Treetop::Runtime::SyntaxNode
    def initialize(input, interval, elements=nil)
      super(input,interval,elements)
      Ministry.tokens << input[interval]
    end
  end
  
  class TextNode < Treetop::Runtime::SyntaxNode
    def initialize(input, interval, elements=nil)
      super(input,interval,elements)
      Ministry.tokens << input[interval]
    end
  end
  
  class NumericNode < Treetop::Runtime::SyntaxNode
    def initialize(input, interval, elements=nil)
      super(input,interval,elements)
      Ministry.tokens << input[interval]
    end
  end
  
  class OperatorNode < Treetop::Runtime::SyntaxNode
    def initialize(input, interval, elements=nil)
      super(input,interval,elements)
      Ministry.tokens << input[interval]
    end
  end 
  
end

class DefinitionParser < Treetop::Runtime::CompiledParser
  include Definition
end

=begin
require 'lib/measures'
Ministry.validate("s")
Ministry.validate("(s)")
Ministry.validate("((s))")
Ministry.validate("((s/2))")
Ministry.validate("1/seconds")
Ministry.validate("m/s^2")
Ministry.validate("-1.5/3")
Ministry.validate("(-1.5/3)")
Ministry.validate("(-1.5(/)3)")
Ministry.validate("(-1(.5/)3)")
Ministry.validate("((-1.5/3))")
Ministry.validate("(((-1.5)/(3)))")
Ministry.validate("(((-1.5)/(3)))")

rule expression # this is where math comes from.
	complex_quantity " "* arithmetic_operators " "* expression+ / complex_quantity / parenthetical_expression
end

rule parenthetical_expression
	open_paren expression close_paren
end

rule complex_exponentiated_expression
	parenthetical_expression " "* exponent_operator " "* number
end

rule complex_quantity
	exponentiated / quantity / (open_paren ( exponentiated / quantity ) close_paren)
end

rule quantity # these are the sorts of things that math can be performed on.
	text / number / (open_paren (text / number) close_paren)
end

rule exponentiated # hey look exponents! "m^2", "m^-2"
	quantity " "* exponent_operators " "* number
end

=end