# frozen_string_literal: true

# Class definition for human player
class Computer
  attr_accessor :name, :symbol

  def initialize(symbol, level)
    @name = "Mister Computer"
    @symbol = symbol
    @level = level
  end

  def levels
    { 1 => "Easy", 2 => "Hard" }
  end
end
