# frozen_string_literal: true

require_relative "player"

# Class definition for human player
class Computer < Player
  attr_accessor :level

  def initialize(symbol, level)
    name = "Mister #{symbol} Computer"
    super(symbol, name)
    @level = level
  end

  # Get computer choice of spot
  def move(board)
    puts "\nIt's #{name}'s turn."
    spot = best_move(board)
    print "Calculating move...  "
    sleep 1
    print spot
    sleep 1
    spot
  end

  def best_move(board)
    # 4 as first spot if available
    if board[4] == "4"
      4
    # choose spot to win or defend
    elsif (spot = win_or_defend_spot(board))
      spot
    # choose one of the corners if available
    elsif @level == 2 && (spot = [0, 2, 6, 8].find { |s| available_spots(board).include?(s) })
      spot
    else
      available_spots(board).sample
    end
  end

  # private

  def win_or_defend_spot(board)
    available_spots(board).find do |spot|
      win_spot?(board, spot, symbol) ||
        (@level == 2 && win_spot?(board, spot, opponent_symbol)) # Defend only if level is hard
    end
  end

  # Iterate over each finish type pattern and return finish type if any
  def win_spot?(board, spot, test_symbol)
    board[spot] = test_symbol

    finish_patterns = [[0, 4, 8], [2, 4, 6], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 1, 2], [3, 4, 5], [6, 7, 8]]
    result = finish_patterns.any? { |pattern| pattern.map { |s| board[s] }.uniq.length == 1 }

    board[spot] = spot.to_s
    result
  end

  def opponent_symbol
    symbol == "X" ? "O" : "X"
  end
end
