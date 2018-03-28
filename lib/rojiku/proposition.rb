# frozen_string_literal: true

class Proposition
  VALID_SYMBOLS = {
    '('   => :left,
    ')'   => :right,
    '->'  => :conditional,
    '&'   => :conjunction,
    '||'  => :disjunction,
    '~'   => :negation,
    '<->' => :biconditional
  }.freeze

  def initialize(raw_formula)
    @raw_formula = raw_formula
  end

  def well_formed?
    return false if unbalanced_parens?
    true
  end

  private

  attr_reader :raw_formula

  def inverted_symbols
    @inverted_symbols ||= VALID_SYMBOLS.invert
  end

  def parsed_formula
    @parsed_formula ||= raw_formula.strip
  end

  def parens
    parsed_formula.chars.select do |character|
      [inverted_symbols[:left], inverted_symbols[:right]].include?(character)
    end
  end

  def unbalanced_parens?
    parens.each_with_object(count: 0) do |paren, hash|
      if paren == inverted_symbols[:left]
        hash[:count] += 1
      else
        hash[:count] -= 1
      end
    end[:count].nonzero?
  end
end
