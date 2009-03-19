require 'treetop'
#require 'lib/measures'; require 'metric/metric'
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
    
    def flatten
      input[interval]
    end
  end
  
  class DefinitionNode < ::Treetop::Runtime::SyntaxNode; end
  
  class OperatorNode < DefinitionNode
    def tokens(options={})
      if options[:normalize] and (input[interval] =~ /\s*(\/|÷)\s*/)
        "*"
      else
        super
      end
    end
  end
  
  class ExponentNode < DefinitionNode
    
  end
  
  class OpArgNode < DefinitionNode
    def tokens(options={})
      if options[:normalize]
        op = operator.tokens
        [op] + expression.tokens(options.merge({:operator=>op}))
      else
        [operator.tokens(options)] + expression.tokens(options)
      end
    end
  end
    
  class QuantityNode < DefinitionNode
    attr_accessor :exponent
    def initialize(input,interval,elements)
      super
      if elements.map{ |e| e.class }.include? Definition::ExponentNode
        @exponent ||= 1
      end
    end
  end

  class ExpressionNode < QuantityNode
    def tokens(options={})
      if options[:normalize]
        if options[:operator] =~ /\*{2}|^/
          
        elsif options[:operator] =~ /\*|\/|÷|×/
          
        else
          raise StandardError
        end
        super
      else
        super
      end
    end
  end
  
  class ParentheticalNode < QuantityNode
  end
  
  class TextNode < QuantityNode
    def tokens(options={})
      if options[:factor]
        factored_definition.tokens
      else
        input[interval]
      end
    end
    
    def factored_definition
      Ministry.identify(measure.input[measure.interval]).factored_definition
    end
  end
  
  class NumericNode < QuantityNode
    def tokens(options={})
      input[interval]
    end
  end
  
end

class DefinitionParser < Treetop::Runtime::CompiledParser
  include Definition
end