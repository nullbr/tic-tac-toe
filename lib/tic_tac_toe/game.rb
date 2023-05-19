# frozen_string_literal: true

# Main Game File
class Game
  attr_accessor :board
  attr_reader :win_type

  # Determine the possible types of game finish
  FINISH_TYPES = {
    diagonal: [[0, 4, 8], [2, 4, 6]],
    vertical: [[0, 3, 6], [1, 4, 7], [2, 5, 8]],
    horizontal: [[0, 1, 2], [3, 4, 5], [6, 7, 8]]
  }.freeze

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @board = %w[0 1 2 3 4 5 6 7 8]
    @current_player = player1
    @win_type = nil
    @moves = 0
  end

  # checks who is current player and sets it to the other player
  def next_player
    @current_player = @current_player == @player1 ? @player2 : @player1
  end

  # returns current player
  def whose_turn
    @current_player
  end

  # returns false if input is invalid
  # return true and calls next player if valid
  def input_to_board(spot)
    return false unless spot_valid?(spot)

    board[spot.to_i] = @current_player.symbol

    # calls next player
    next_player

    true
  end

  # Checks all game possibilities and returns true if game won or false if not
  def game_is_over?
    if (type = check_patterns)
      @win_type = type.to_s
    elsif @moves == 9
      @win_type = "tie"
    end

    !@win_type.nil?
  end

  # returns the winner
  def winner
    return if @win_type.nil?

    next_player
    # if @win_type == "Draw"
    #   puts "Nobody won :("
    # elsif @win_type.nil?
    #   puts "You ended the game, nobody won"
    # else
    #   puts "And the Winner is #{@current_player}!!!"
    # end
  end

  # return formatted board
  def display_the_board
    b = board
    " #{b[0]} | #{b[1]} | #{b[2]}\n===+===+===\n #{b[3]} | #{b[4]} " \
    "| #{b[5]}\n===+===+===\n #{b[6]} | #{b[7]} | #{b[8]}\n"
  end
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
    spot = spot.is_a?(Integer) ? spot.to_s : spot

    /^\d$/.match?(spot) &&
      spot.to_i.between?(0, 8) &&
      !%w[X O].include?(board[spot.to_i])
  end
end
