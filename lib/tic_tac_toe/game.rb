# frozen_string_literal: true

# Main Game File
class Game
  attr_accessor :board
  attr_reader :win_type

  FINISH_TYPES = {
    diagonal: [[0, 4, 8], [2, 4, 6]],
    vertical: [[0, 3, 6], [1, 4, 7], [2, 5, 8]],
    horizontal: [[0, 1, 2], [3, 4, 5], [6, 7, 8]]
  }.freeze

  def initialize(player1 = "", player2 = "")
    @player1 = player1 == "" ? "Player X" : player1
    @player2 = player2 == "" ? "Player O" : player2
    @board = %w[0 1 2 3 4 5 6 7 8]
    @turn = player1
    @win_type = nil
    @moves = 0
  end

  def next_player
    @turn = @turn == @player1 ? @player2 : @player1
  end

  def whose_turn
    "It's #{@turn}'s turn"
  end

  # returns false if input is invalid
  # return true and calls next player if valid
  def input_to_board(spot)
    if spot_valid?(spot)
      board[spot.to_i] = @turn == @player1 ? "X" : "O"

      # calls next player
      next_player

      true
    else
      puts "\nThis spot is non existent or is taken, go again\n"
      false
    end
  end

  # # Check if game was won horizontally
  # def horizontal_win?
  #   # repeat for every row
  #   return false unless check_line(0, 1, 2) || check_line(3, 4, 5) || check_line(6, 7, 8)

  #   @win_type = "Horizontal"
  #   true
  # end

  # # Check if game was won vertically
  # def vertical_win?
  #   # repeat for every column
  #   return false unless check_line(0, 3, 6) || check_line(1, 4, 7) || check_line(2, 5, 8)

  #   @win_type = "Vertical"
  #   true
  # end

  # # check if game was won diagonaly
  # def diagonal_win?
  #   # return if spot for is not taken and not won diagonally
  #   return false unless %w[X O].include?(board[4]) && (check_line(0, 4, 8) || check_line(2, 4, 6))

  #   @win_type = "Diagonal"
  #   true
  # end

  # # checks if game is tied
  # def tied?
  #   return true unless board.all? { |spot| %w[X O].include?(spot) }

  #   @win_type = "Tie"
  #   true
  # end

  # Checks all game possibilities and returns true if game won or false if not
  def game_is_over?
    @win_type = @moves == 9 ? "tie" : check_patterns

    @win_type.nil?
  end

  def winner
    next_player
    if @win_type == "Draw"
      puts "Nobody won :("
    elsif @win_type.nil?
      puts "You ended the game, nobody won"
    else
      puts "And the Winner is #{@turn}!!!"
    end
  end

  # return formatted board
  # rubocop:disable Layout/LineLength
  def display_the_board
    b = board
    " #{b[0]} | #{b[1]} | #{b[2]}\n===+===+===\n #{b[3]} | #{b[4]} | #{b[5]}\n===+===+===\n #{b[6]} | #{b[7]} | #{b[8]}\n"
  end
  # rubocop:enable Layout/LineLength

  # private

  # Iterate over each finish type pattern and return finish type if any
  def check_patterns
    FINISH_TYPES.select { |_name, patterns| patterns.any? { |pattern| check_line(pattern) } }.keys.first
  end

  # check if line passed has only X or O to determine if game is over
  def check_line(pattern)
    spots = pattern.map { |spot_num| board[spot_num] }

    spots.uniq.length == 1
  end

  # Check if spot is only a number, between 0 and 8 and not taken
  def spot_valid?(spot)
    /^\d$/.match?(spot) &&
      spot.to_i.between?(0, 8) &&
      !%w[X O].include?(board[spot.to_i])
  end
end
