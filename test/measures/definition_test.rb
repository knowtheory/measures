require File.dirname(__FILE__) + '/../test_helper'
require 'treetop'

class DefinitionTest < Test::Unit::TestCase
  context "Definition Grammar" do
    setup do
      Treetop.load File.expand_path("./lib/measures/definition/definition")
      @parser = DefinitionParser.new
    end
    
    context "Parsing" do
      context "Terminal Nodes" do
        should "recognize numbers" do
          inputs = ["1", "1234", "3.141529", "-1234", "-2.71828", "- 2.1233"]
          inputs.each do |number|
            assert @parser.parse(number), "parser didn't recognize '#{number}'"
          end
        end
  
        should "recognize alphabetic (and greek) strings" do
          inputs = ["Spike", "Faye", "Ed", "Ein", "haberdashery", "measure", "prefix.measure", "Ωµπ∂∆"]
          inputs.each do |text|
            assert @parser.parse(text), "parser didn't recognize '#{text}'"
          end
        end
  
        should "reject non-alphanumeric strings" do
          inputs = %w( ! @ # $ % & [ ] { } | \ : " ; ' < > ? , ).map do |c| 
                  ["words#{c}meaning", "words #{c} meaning"]
          end.flatten
          inputs += ["3.3.3.3.3", "1. 2334", "1 .234", "yay_underscores", "5%", "40$", "word^", "^cake", "1.asdf" ]
          inputs.each do |text|
            assert_nil @parser.parse(text), "parser recognized '#{text}' when it shouldn't have"
          end
        end
      end
    
      should "recognize binary arithmetic expressions" do
        inputs  = ["123 + 321", "123 - 321", "123 * 321", "123 / 321"]
        inputs += ["maps + 123","maps - 123","maps * 123","maps / 123"]
        inputs.each do |expression|
          assert @parser.parse(expression), "parser didn't recognize '#{expression}'"
        end
      end
    
      should "recognize compound expressions" do
        inputs = ["1 + 2 + 3", "a + b + c", "a * 2 / b^3"]
        inputs.each do |expression|
          assert @parser.parse(expression), "parser didn't recognize '#{expression}'"
        end
      end
    
      should "recognize exponentiation" do
        inputs  = ["m^2", "m**2", "metres^2", "metres**2", "m^-2"] 
        inputs += ["(m)**2", "(m)^2", "(m)**-2", "(m)^-2","(m*a)**2", "(m*a)^2"]
        inputs.each do |phrase|
          assert @parser.parse(phrase), "parser didn't recognize '#{phrase}'"
        end
      end
    
      should "recognize parenthetical expressions" do
        # standard inputs wrapped in parens
        inputs  = ["(m^2)", "(meters)", "(1234)", "(a/b)", "( m^2 )", "( meters )", "( 1234 )", "( a / b )", "a / (b * c)"] 
        # nested parentheticals
        inputs += ["((a)/b)", "((a/b))", "(a/(b))", "(a/((b)))"]
        # exponentiated parentheticals
        inputs += ["(a/b)^3", "( a / b ) ^ 3", "(a^2)^3/4"]
        inputs.each do |expression|
          assert @parser.parse(expression), "parser didn't recognize '#{expression}'"
        end
      end
    
      should "reject incorrect parenthetical pairs" do
        inputs = ["(a/)b", "a(/)b", "a () b", "a (b) c" ]
        inputs.each do |expression|
          assert_nil @parser.parse(expression), "parser recognized '#{expression}' when it shouldn't have"
        end
      end
    
      should "recognize things that will be used in measures" do
        inputs = ["m^2/s", "V*s/m^2", "kg^-1*s^3*mol^-1*A^2"]
        inputs.each do |expression|
          assert @parser.parse(expression), "parser didn't recognize '#{expression}'"
        end
      end
    end
  end
end