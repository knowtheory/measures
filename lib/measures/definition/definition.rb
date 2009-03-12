require 'treetop'
=begin
require 'lib/measures'
Ministry.parse("a*b").tokens
Ministry.parse("a/b/c").tokens
=end


module Definition
  include Treetop::Runtime
  
  class ::Treetop::Runtime::SyntaxNode
    def tokens(options={})
      if nonterminal?
        return elements.map{ |e| e.tokens(options) }.flatten.compact
      elsif input[interval].empty?
        return nil
      else
        return input[interval]
      end
    end
  end
  
  class DefinitionNode < Treetop::Runtime::SyntaxNode
    def initialize(input, interval, elements=nil)
      super(input,interval,elements)
      Ministry.tokens << input[interval]
    end
  end
  
  class DivisionNode < DefinitionNode
    def initialize(input, interval, elements=nil)
      super(input,interval,elements)
    end
    
    def exponential_form(options={})
      ["*", "(", expression.tokens(options), ")", "^", "-1"].flatten
    end
    
    def tokens(options={})
      super
    end
  end
  
  class ParenNode < DefinitionNode
  end
  
  class TextNode < DefinitionNode
  end
  
  class NumericNode < DefinitionNode
  end
  
  class OperatorNode < DefinitionNode
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