# frozen_string_literal: true

# Main Game File
class Game
  attr_accessor :board
  attr_reader :win_type

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @board = %w[0 1 2 3 4 5 6 7 8]
    @turn = player1
    @win_type = ""
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

  def game_horizontal
    board.each do |row|
      if row.all? { |spot| spot == "X" }
        @win_type = "Horizontal"
      elsif row.all? { |spot| spot == "0" }
        @win_type = "Horizontal"
      end
    end
  end

  # Check if game was won vertically
  def vertical_win
    # repeat for every column
    return unless check_line(0, 3, 6) || check_line(1, 4, 7) || check_line(2, 5, 8)

    @win_type = "Vertical"
  end

  def game_diagonal
    middle = board[1][1]
    return unless %w[X O].include?(board[4])

    if board[0][0] == middle && middle == board[2][2]
      @win_type = "Diagonal"
    elsif board[0][2] == middle && middle == board[2][0]
      @win_type = "Diagonal"
    end
  end

  # checks if game is tied
  def tied
    return unless board.all? { |spot| %w[X O].include?(spot) }

    @win_type = "Tie"
  end

  def game_not_over?
    [game_vertical, game_horizontal, game_diagonal, draw].each do
      unless @win_type.nil?
        puts "Finish type #{@win_type}"
        break
      end
    end
    @win_type.nil? ? true : false
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

  # check if line passed has only X or O to determine if game is over
  def check_line(a, b, c)
    [board[a], board[b], board[c]].uniq.length == 1
  end

  # Check if spot is only a number, between 0 and 8 and not taken
  def spot_valid?(spot)
    /^\d$/.match?(spot) &&
      spot.to_i.between?(0, 8) &&
      !%w[X O].include?(board[spot.to_i])
  end
end
