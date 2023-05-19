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
end
