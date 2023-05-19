# frozen_string_literal: true

# Class definition for human player
class Player
  attr_reader :symbol

  def initialize(symbol)
    @symbol = symbol
  end

  def symbols
    %w[X O]
  end
end
