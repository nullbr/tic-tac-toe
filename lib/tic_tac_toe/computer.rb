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

  def eval_board
    spot = nil
    until spot
      if @board[4] == "4"
        spot = 4
        @board[spot] = @com
      else
        spot = get_best_move(@board, @com)
        if @board[spot] != "X" && @board[spot] != "O"
          @board[spot] = @com
        else
          spot = nil
        end
      end
    end
  end

  def get_best_move(board, _next_player, _depth = 0, _best_score = {})
    available_spaces = []
    best_move = nil
    board.each do |s|
      available_spaces << s if s != "X" && s != "O"
    end
    available_spaces.each do |as|
      board[as.to_i] = @com
      if game_is_over(board)
        best_move = as.to_i
        board[as.to_i] = as
        return best_move
      else
        board[as.to_i] = @hum
        if game_is_over(board)
          best_move = as.to_i
          board[as.to_i] = as
          return best_move
        else
          board[as.to_i] = as
        end
      end
    end
    return best_move if best_move

    n = rand(0..available_spaces.count)
    available_spaces[n].to_i
  end
end
