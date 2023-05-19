# frozen_string_literal: true

require_relative "player"

# Class definition for human player
class Human < Player
  attr_accessor :name

  def initialize(symbol, name = "")
    name = name == "" ? "Player #{symbol}" : name
    super(symbol, name)
  end
end
