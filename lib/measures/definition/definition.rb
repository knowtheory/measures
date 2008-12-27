require 'treetop'

module Definition
  include Treetop::Runtime
  
  class TextNode < Treetop::Runtime::SyntaxNode
    def initialize(input, interval, elements=nil)
      super(input,interval,elements)
    end
  end
  
  class NumericNode < Treetop::Runtime::SyntaxNode
    def initialize(input, interval, elements=nil)
      super(input,interval,elements)
    end
  end
end

class DefinitionParser < Treetop::Runtime::CompiledParser
  include Definition
end