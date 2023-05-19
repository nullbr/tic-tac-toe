# frozen_string_literal: true

require "ruby_figlet"
using RubyFiglet

require_relative "game"
require_relative "human"
require_relative "computer"
require_relative "process_input"

# Game play file
class GamePlay
  attr_reader :player1, :player2

  def initialize
    @game_mode = nil
    @player1 = nil
    @player2 = nil
    @available_symbols = %w[X O]
  end

  def start_game
    # Welcome
    welcome_message
    # Get game mode
    set_game_mode
    # Create players
    set_players
    # create game
    @game = Game.new(@player1, @player2)
  end

  # def start_game
  #   # start by printing the board
  #   puts @game.display_the_board

  #   puts "Enter [0-8]:"
  #   # loop through until the game was won or tied
  #   while game_not_over?
  #     puts game.whose_turn

  #     get_human_spot
  #     eval_board unless game_not_over?
  #     puts display_the_board
  #   end
  #   puts "Game over"
  # end

  def welcome_message
    puts "Tic Tac Toe".art
    puts "\t\t\t\t\t   by Bruno Leite"
    puts "\nLets Play!"
  end

  def set_game_mode
    puts "Please choose a game mode (0, 1 or 3):\n" \
    "\t0 -> Human vs Human\n\t1 -> Human vs Computer\n\t2 -> Computer vs Computer"

    @game_mode = capture_input([0, 1, 2]) until @game_mode

    @game_mode
  end

  def set_players
    if @game_mode.zero?
      @player1 = human_player(1)
      @player2 = human_player(2)
    elsif @game_mode == 1
      @player1 = human_player(1)
      @player2 = Computer.new(@available_symbols.first)
    else
      @player1 = Computer.new(@available_symbols.first)
      @player2 = Computer.new(@available_symbols.first)
    end
  end

  private

  def human_player(num)
    puts "Please enter a name for player #{num}:\n"
    name = capture_input

    puts "Would you like to play as #{@available_symbols.first} or #{@available_symbols.last}?\n"
    symbol = capture_input(@available_symbols) until symbol
    @available_symbols.delete(symbol)

    Human.new(symbol, name)
  end

  # Helper method to process user input cleanly
  def capture_input(options = " ")
    ProcessInput.new.capture_input(options)
  end
end
