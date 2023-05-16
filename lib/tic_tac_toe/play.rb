# frozen_string_literal: true

require_relative "game"

# Game play file
class Play
  def initialize
    @game = Game.new("bruno", "giu")
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

  def display_the_board
    board = @game.board
    " #{board[0]} | #{board[1]} | #{board[2]}\n===+===+===\n #{board[3]} | #{board[4]} | #{board[5]}\n===+===+===\n #{board[6]} | #{board[7]} | #{board[8]}\n"
  end
end
