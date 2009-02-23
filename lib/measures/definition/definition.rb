require 'treetop'

module Definition
  include Treetop::Runtime
  
  class TextNode < Treetop::Runtime::SyntaxNode
    def initialize(input, interval, elements=nil)
      super(input,interval,elements)
      Ministry.current_parse << input[interval]
    end
  end
  
  class NumericNode < Treetop::Runtime::SyntaxNode
    def initialize(input, interval, elements=nil)
      super(input,interval,elements)
      Ministry.current_parse << input[interval]
    end
  end
  
  class OperatorNode < Treetop::Runtime::SyntaxNode
    def initialize(input, interval, elements=nil)
      super(input,interval,elements)
      Ministry.current_parse << input[interval]
    end
  end 
end

class DefinitionParser < Treetop::Runtime::CompiledParser
  include Definition
end

=begin
require 'lib/measures'
Ministry.validate("1/seconds")
Ministry.validate("m/s^2")
Ministry.validate("-1.5/3")
Ministry.validate("(-1.5/3)")
Ministry.validate("(-1.5(/)3)")
Ministry.validate("(-1(.5/)3)")
Ministry.validate("((-1.5/3))")
Ministry.validate("(((-1.5)/(3)))")
Ministry.validate("(((-1.5)/(3)))")

=end