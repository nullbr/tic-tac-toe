# frozen_string_literal: true

# Main Game File
class Game
  attr_reader :board

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @board = %w[0 1 2 3 4 5 6 7 8]
    @turn = player1
    @draw = 0
    @game_type = nil
  end

  def current_player
    @draw += 1
    @turn = @turn == @player1 ? @player2 : @player1
  end

  def whose_turn
    "It's #{@turn}'s turn"
  end

  def input_to_board(row, column)
    row = row.to_i
    column = column.to_i
    if row.between?(1, 3) && column.between?(1, 3) && @board[row - 1][column - 1] == " "
      @board[row - 1][column - 1] = @turn == @player1 ? "X" : "O"
      current_player
    else
      puts "\nThis spot is non existent or is taken, go again\n"
    end
  end

  def game_horizontal
    @board.each do |row|
      if row.all? { |spot| spot == "X" }
        @game_type = "Horizontal"
      elsif row.all? { |spot| spot == "0" }
        @game_type = "Horizontal"
      end
    end
  end

  def game_vertical
    n = 0
    3.times do
      @game_type = "Vertical" if @board[0][n] != " " && @board[0][n] == @board[1][n] && @board[1][n] == @board[2][n]
      n += 1
    end
  end

  def game_diagonal
    middle = @board[1][1]
    return if middle == " "

    if @board[0][0] == middle && middle == @board[2][2]
      @game_type = "Diagonal"
    elsif @board[0][2] == middle && middle == @board[2][0]
      @game_type = "Diagonal"
    end
  end

  def draw
    @game_type = "Draw" if @draw == 9
  end

  def game_not_over?
    [game_vertical, game_horizontal, game_diagonal, draw].each do
      unless @game_type.nil?
        puts "Finish type #{@game_type}"
        break
      end
    end
    @game_type.nil? ? true : false
  end

  def winner
    current_player
    if @game_type == "Draw"
      puts "Nobody won :("
    elsif @game_type.nil?
      puts "You ended the game, nobody won"
    else
      puts "And the Winner is #{@turn}!!!"
    end
  end

  def display_the_board
    board = "\nColumn     1   2   3\n"
    n = 0
    3.times do
      board += "Row    #{n + 1} [ #{@board[n][0]} | #{@board[n][1]} | #{@board[n][2]} ]\n"
      n += 1
    end
    board
  end
end
