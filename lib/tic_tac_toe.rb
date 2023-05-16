# frozen_string_literal: true

require "./lib/tic_tac_toe/game"

puts "Insert player X name: "
player1 = gets.chomp
puts "Insert player O name: "
player2 = gets.chomp
game = TicTacToe.new(player1, player2)

system "clear"
puts game.display_the_board

while game.game_not_over?
  puts game.whose_turn
  puts "Insert the row of your choice:"
  row = gets.chomp
  break if row.downcase == "quit" || row.downcase == "end"

  puts "Insert the column of your choice:"
  column = gets.chomp
  break if column.downcase == "quit" || column.downcase == "end"

  game.input_to_board(row, column)

  system "clear"
  puts game.display_the_board
end

game.winner
