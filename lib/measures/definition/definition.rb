# -*- coding: utf-8 -*-
require 'treetop'
#require 'lib/measures'; require 'metric/metric'
module Definition
  include Treetop::Runtime
  
  class ::Treetop::Runtime::SyntaxNode
    def tokens(options={})
      #pp options
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
    
    def normalize(options={})
      tokens(options.merge({:normalize=>true}))
    end
    
    def factor(options={})
      tokens(options.merge({:factor=>true}))
    end
  end
  
  class DefinitionNode < ::Treetop::Runtime::SyntaxNode; end
  
  class OperatorNode < DefinitionNode
    def tokens(options={})
      #pp options
      if options[:normalize] and (input[interval] =~ /\s*(\/|÷)\s*/)
        "*"
      else
        super
      end
    end
  end
  
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
        ["*"] + expression.tokens(options.merge({:exponent=>-1*exp}))
      else
        super
      end
    end
  end
    
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
      when (nonterminal? and options[:normalize])
        value.tokens(options.merge(:exponent => exp))
      when nonterminal?
        super(options.merge(:exponent => exp))
      else
        input[interval]
      end
    end
  end

  class ExpressionNode < QuantityNode
    def tokens(options={})
      exp = exponent
      unless options[:exponent].nil?
        exp = exponent * options[:exponent]
      end
      #pp options
      return elements.map{ |e| e.tokens(options.merge(:exponent => exp)) }.flatten.compact
    end
  end
  
  class ParentheticalNode < QuantityNode
    def tokens(options={})
      #pp options
      exp = exponent
      unless options[:exponent].nil?
        exp = exponent * options[:exponent]
      end
      if options[:normalize]
        children = expression.tokens(options.merge(:exponent => exp))
        unless children.include? "-" or children.include?("+")
          children
        else
          ["(", children, ")"].flatten
        end
      else
        super
      end
    end
  end
  
  class TextNode < QuantityNode
    def tokens(options={})
      #pp [self, options]
      token_store = []
      if options[:factor]
        token_store = factored_definition.tokens
      else
        token_store = input[interval]
      end
      
      if options[:normalize]
        if options[:exponent] and options[:exponent] != 1
          token_store = [token_store + "^" + "#{exponent * options[:exponent]}"].flatten
        else
          token_store
        end
      else
        token_store
      end
    end
    
    def factored_definition
      Ministry.identify(measure.input[measure.interval]).factored_definition
    end
  end
  
  class NumericNode < QuantityNode
    def tokens(options={})
      #puts options
      if options[:normalize]
        if options[:exponent] and options[:exponent] != 1
          [input[interval], "^", "#{exponent * options[:exponent]}"].flatten
        else
          input[inteval]
        end
      else
        input[interval]
      end
    end
  end
  
end

class DefinitionParser < Treetop::Runtime::CompiledParser
  include Definition
end