# frozen_string_literal: true

require_relative "player"

# Class definition for human player
class Computer < Player
  attr_accessor :name

  def initialize(symbol, level)
    super(symbol)
    @name = "Mister Computer"
    @level = level
  end

  def levels
    { 1 => "Easy", 2 => "Hard" }
  end
end
