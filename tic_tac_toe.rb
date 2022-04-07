require 'pry'

class TicTackToe

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @game = [[' ', ' ', ' '], [' ', ' ', ' '], [' ', ' ', ' ']]
    @turn = player1
    @not_over = true
    @velha = 0
  end

  def current_player
    if @turn == @player1
      @turn = @player2
    else
      @turn = @player1
    end
  end

  def whose_turn
    puts "It's #{@turn}'s turn." 
    puts "Insert the row of your choice:"
    @row = gets.chomp.to_i
    puts "Insert the column of your choice:"
    @column = gets.chomp.to_i
    input_to_board
    @velha += 1
  end

  def input_to_board
    if @game[@row][@column] == ' '
      if @turn == @player1
        @game[@row][@column] = "I"
      else
        @game[@row][@column] = "O"
      end
      current_player
    else
      puts "This spot is taken, go again"
      whose_turn
    end
  end

  def game_horizontal
    @game.each do |row|
      if row.all? { |spot| spot == "I" }
        @not_over = false
      elsif row.all? { |spot| spot == "0" }
        @not_over = false
      end
    end
    @not_over
  end

  def game_vertical
    n = 0
    3.times do
      @not_over = false if @game[0][n] != ' ' && @game[0][n] == @game[1][n] && @game[1][n] == @game[2][n]
    end
    @not_over
  end

  def game_diagonal
    if @game[0][0] != ' ' && @game[0][0] == @game[1][1] && @game[1][1] == @game[2][2]
      @not_over = false
    elsif @game[0][2] != ' ' && @game[0][2] == @game[1][1] && @game[1][1] == @game[2][0]
      @not_over = false
    end
    @not_over
  end

  def velha
    @not_over = false if @velha == 9
    @not_over
  end


  def game_not_over?
    if game_horizontal && game_vertical && game_diagonal && velha
      true
    else
      false
    end
  end

  def winner
    current_player 
    puts "And the Winner is #{@turn}!!"
  end
  
  def display_the_board
    puts "Column   0 | 1 | 2  "
    n = 0
    3.times do
      puts "Row #{n}: [ #{@game[n][0]} | #{@game[n][1]} | #{@game[n][2]} ]"
      n +=1
    end
  end
end

puts "Insert player's 1 name: "
player1 = gets.chomp
puts "Insert player's 2 name: "
player2 = gets.chomp
game = TicTackToe.new(player1, player2)
game.display_the_board

p game.game_not_over?
while game.game_not_over? do
  game.whose_turn
  game.display_the_board
end

game.winner

