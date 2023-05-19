# frozen_string_literal: true

# Class definition for human player
class Player
  attr_reader :symbol, :name

  def initialize(symbol, name)
    @symbol = symbol
    @name = name
  end
end
