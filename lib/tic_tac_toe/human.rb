# frozen_string_literal: true

# Class definition for human player
class Human
  attr_accessor :name, :symbol

  def initialize(symbol, name = "")
    @symbol = symbol
    @name = name == "" ? "Player #{symbol}" : name
  end
end
