# frozen_string_literal: true

# Class definition for human player
class Player
  attr_reader :symbol, :name

  def initialize(symbol, name, first)
    @symbol = symbol
    @name = name
    @first_player = first
  end

  def first?
    @first_player
  end
end
