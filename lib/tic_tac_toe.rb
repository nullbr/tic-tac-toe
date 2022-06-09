class TicTackToe
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @game = [[' ', ' ', ' '], [' ', ' ', ' '], [' ', ' ', ' ']]
    @turn = player1
    @draw = 0
    @game_type = nil
  end

  def current_player
    @draw += 1
    @turn = if @turn == @player1
              @player2
            else
              @player1
            end
  end

  def whose_turn
    "It's #{@turn}'s turn"
  end

  def input_to_board(row, column)
    row = row.to_i
    column = column.to_i
    if @game[row - 1][column - 1] == ' ' && row.between?(1, 3) && column.between?(1, 3)
      @game[row - 1][column - 1] = if @turn == @player1
                                     'X'
                                   else
                                     'O'
                                   end
      current_player
    else
      puts "\nThis spot is non existent or is taken, go again\n"
    end
  end

  def game_horizontal
    @game.each do |row|
      if row.all? { |spot| spot == 'X' }
        @game_type = 'Horizontal'
      elsif row.all? { |spot| spot == '0' }
        @game_type = 'Horizontal'
      end
    end
  end

  def game_vertical
    n = 0
    3.times do
      @game_type = 'Vertical' if @game[0][n] != ' ' && @game[0][n] == @game[1][n] && @game[1][n] == @game[2][n]
      n += 1
    end
  end

  def game_diagonal
    middle = @game[1][1]
    unless middle == ' '
      if @game[0][0] == middle && middle == @game[2][2]
        @game_type = 'Diagonal'
      elsif @game[0][2] == middle && middle == @game[2][0]
        @game_type = 'Diagonal'
      end
    end
  end

  def draw
    @game_type = 'Draw' if @draw == 9
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
    if @game_type == 'Draw'
      puts 'Nobody won :('
    elsif @game_type.nil?
      puts 'You ended the game, nobody won'
    else
      puts "And the Winner is #{@turn}!!!"
    end
  end

  def display_the_board
    puts "\nColumn     1   2   3"
    n = 0
    3.times do
      puts "Row    #{n + 1} [ #{@game[n][0]} | #{@game[n][1]} | #{@game[n][2]} ]"
      n += 1
    end
    puts ' '
  end
end

puts 'Insert player X name: '
player1 = gets.chomp
puts 'Insert player O name: '
player2 = gets.chomp
game = TicTackToe.new(player1, player2)
game.display_the_board

while game.game_not_over?
  puts game.whose_turn
  puts 'Insert the row of your choice:'
  row = gets.chomp
  break if row.downcase == 'quit' || row.downcase == 'end'

  puts 'Insert the column of your choice:'
  column = gets.chomp
  break if column.downcase == 'quit' || column.downcase == 'end'

  game.input_to_board(row, column)
  game.display_the_board
end

game.winner
