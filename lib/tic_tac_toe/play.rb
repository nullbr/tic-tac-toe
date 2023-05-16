# frozen_string_literal: true

require_relative "game"

require "ruby_figlet"
using RubyFiglet

# Game play file
class Play
  def initialize
    # Welcome
    welcome_message

    # get players names
    player1 = capture_name("X")
    player2 = capture_name("O")

    # create game
    @game = Game.new(player1, player2)
    start_game
  end

  def start_game
    # start by printing the board
    puts display_the_board

    puts "Enter [0-8]:"
    # loop through until the game was won or tied
    while game_not_over?
      get_human_spot
      eval_board unless game_not_over?
      puts display_the_board
    end
    puts "Game over"
  end

  def welcome_message
    puts "Tic Tac Toe".art
    puts "\t\t\t\t\t   by Bruno Leite"
    puts "\nLets Play!"
  end

  def capture_name(symbol)
    puts "Insert player #{symbol} name: "
    gets.chomp
  end

  # rubocop:disable Layout/LineLength
  def display_the_board
    board = @game.board
    puts " #{board[0]} | #{board[1]} | #{board[2]}\n===+===+===\n #{board[3]} | #{board[4]} | #{board[5]}\n===+===+===\n #{board[6]} | #{board[7]} | #{board[8]}\n"
  end
  # rubocop:enable Layout/LineLength
end
