require File.dirname(__FILE__) + '/../test_helper'
require 'treetop'

class DefinitionTest < Test::Unit::TestCase
  context "Definition Grammar" do
    setup do
      Treetop.load File.expand_path("./lib/measures/definition/definition")
      @parser = DefinitionParser.new
    end
    
    context "recognize valid and reject invalid lexical nodes" do
      should "accept numbers" do
        inputs = ["1", "1234", "3.141529", "-1234", "-2.71828"]
        inputs.each do |number|
          assert @parser.parse(number), "parser didn't recognize '#{number}'"
        end
      end
    
      should "accept alphabetic strings" do
        inputs = ["Spike", "Faye", "Ed", "Ein", "haberdashery", "measure"]
        inputs.each do |text|
          assert @parser.parse(text), "parser didn't recognize '#{text}'"
        end
      end
    
      should "reject non-alphanumeric strings" do
        inputs = %w( ! @ # $ % & [ ] { } | \ : " ; ' < > ? , . ).map do |c| 
                ["words#{c}meaning", "words #{c} meaning"]
        end.flatten
        inputs += ["3.3.3.3.3", "yay_underscores", "5%", "40$", "word^", "^cake" ""]
        inputs.each do |text|
          assert_nil @parser.parse(text), "parser recognized '#{text}' when it shouldn't have"
        end
      end
    end
    
    should "recognize exponentiation" do
      inputs = ["m^2", "m**2", "metres^2", "metres**2", "m^-2"]
      inputs.each do |phrase|
        assert @parser.parse(phrase), "parser didn't recognize '#{phrase}'"
      end
    end
    
    should "recognize binary arithmetic expressions" do
      inputs  = ["123 + 321", "123 - 321", "123 * 321", "123 / 321"]
      inputs += ["maps + 123"]
      inputs.each do |expression|
        assert @parser.parse(expression), "parser didn't recognize '#{expression}'"
      end
    end
    
  end
end