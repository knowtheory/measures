# -*- coding: utf-8 -*-
require 'treetop'
#require 'lib/measures'; require 'metric/metric'
module TreetopExt
    def tokens(options={})
      #pp options
      if nonterminal?
        return elements.map{ |e| e.tokens(options) }.flatten.compact
      elsif input[interval].empty? or input[interval] =~ /\s+/
        return nil
      else
        return input[interval]
      end
    end

    def flatten
      input[interval]
    end

    def normalize(options={})
      tokens(options.merge({:normalize=>true,:distribute=>true,:simplify=>true}))
    end

    def factor(options={})
      normalize(options.merge(:factor=>true))
    end
end

class Treetop::Runtime::SyntaxNode
  include TreetopExt
end

module Definition
  include Treetop::Runtime
    
  class DefinitionNode < ::Treetop::Runtime::SyntaxNode; end
  
  class OperatorNode < DefinitionNode; end
  
  class ExponentNode < DefinitionNode
    def value
      basic_quantity.input[basic_quantity.interval]
    end
  end
  
  class OpArgNode < DefinitionNode
    def tokens(options={})
      #pp options
      op = operator.tokens
      if options[:normalize] and op =~ /\/|÷/
        exp = options[:exponent]
        exp ||= 1
        ["*"] + [expression.tokens(options.merge({:exponent=>-1*exp}))].flatten.compact
      else
        super
      end
    end
  end
    
  class ExpressionNode < DefinitionNode
  end
  
  #
  # QuantityNodes are the base type for anything that has a value.
  # This includes basic quantities (strings or numbers) complex expressions
  # and parenthetical expressions.
  #
  # Quantities can have exponents
  class QuantityNode < DefinitionNode
    attr_accessor :exponent
    def initialize(input,interval,elements)
      super
      unless (element = elements.select{ |e| e.is_a? Definition::ExponentNode }.first).nil?
        exp = element.basic_quantity
        @exponent = exp.input[exp.interval].to_f
      else
        @exponent ||= 1
      end
    end
    
    def tokens(options={})
      #pp options
      exp = exponent
      unless options[:exponent].nil?
        exp = exponent * options[:exponent]
      end
      
      case 
        when (nonterminal? and options[:distribute])
          value.tokens(options.merge(:exponent => exp))
        when nonterminal?
          super(options.merge(:exponent => exp))
        else
          input[interval]
      end
    end
  end
  
  class ParentheticalNode < QuantityNode
    def tokens(options={})
      #pp options
      exp = exponent
      unless options[:exponent].nil?
        exp = exponent * options[:exponent]
      end

      children = expression.tokens(options.merge(:exponent => exp))
      case
        when (options[:simplify] and parent.parent.is_a? ExpressionNode)
          children.flatten
        when (options[:simplify] and not (children.include?("-") or children.include?("+") or options[:exponent] != 1))
          children.flatten
        else
          ["(", children, ")"].flatten
      end
    end
  end
  
  class TextNode < QuantityNode
    def tokens(options={})
      #pp [self, options]
      token_store = options[:factor] ? factored_definition.tokens : input[interval]
      if options[:distribute] and options[:exponent] != 1
        return [token_store + "^" + "#{exponent * options[:exponent]}"].flatten
      else
        return token_store
      end
    end
    
    def factored_definition
      Ministry.identify(measure.input[measure.interval]).factored_definition
    end
  end
  
  class NumericNode < QuantityNode
    def tokens(options={})
      #puts options
      if options[:distribute] and options[:exponent] != 1
        [input[interval], "^", "#{exponent * options[:exponent]}"].flatten
      else
        input[interval]
      end
    end
  end
  
end

class DefinitionParser < Treetop::Runtime::CompiledParser
  include Definition
end