# frozen_string_literal: true

require_relative "player"

# Class definition for human player
class Computer < Player
  attr_accessor :level

  def initialize(symbol)
    name = "Mister Computer"
    super(symbol, name)
    @level = nil
  end

  def levels
    { 1 => "Easy", 2 => "Hard" }
  end

  # Get computer choice of spot
  def move(game)
    if game.available_spots.include?(4)
      4
    else
      get_best_move(game)
    end
  end

  def get_best_move(game)
    game.available_spots.select do |spot|
      if game.will_be_over?(spot, @symbol)
        spot
      elsif game.will_be_over?(spot, opponent_symbol)
        spot
      end
    end.first
  end

  def opponent_symbol
    @symbol == "X" ? @symbol : "O"
  end
end
