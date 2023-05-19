# frozen_string_literal: true

require "ruby_figlet"
using RubyFiglet

require_relative "game"
require_relative "human"
require_relative "computer"

# Game play file
class GamePlay
  attr_reader :player1, :player2

  def initialize
    @game_mode = nil
    @player1 = nil
    @player2 = nil
  end

  def start_game
    # Welcome
    welcome_message

    # Get game mode
    set_game_mode

    # create game
    @game = Game.new(player1, player2)
    start_game
  end

  def welcome_message
    puts "Tic Tac Toe".art
    puts "\t\t\t\t\t   by Bruno Leite"
    puts "\nLets Play!"
  end

  def set_game_mode
    puts "Please choose a game mode (0, 1 or 3):\n" \
    "\t0 -> Human vs Human\n\t1 -> Human vs Computer\n\t2 -> Computer vs Computer"

    @game_mode = get_input([0, 1, 2]) until @game_mode

    @game_mode
  end

  def create_players
    if @game_mode.zero?
      @player1 = Human.new("X")
      @player2 = Human.new("O")
    elsif @game_mode == 1
      @player1 = Human.new("X")
      @player2 = Computer.new("O")
    else
      @player1 = Computer.new("X")
      @player2 = Computer.new("O")
    end
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

  def capture_name(symbol)
    puts "\nInsert player #{symbol} name: "
    gets.chomp
  end

  def get_input(options = " ")
    input = gets.chomp.strip

    return if display_help(input)

    exit_game(input) || validate_input(input, options) || input_invalid(options)
  end

  private

  def exit_game(input)
    return unless %w[quit end exit].include?(input.downcase)

    abort("Exiting the game...")
  end

  # Returns input if there are no options (no constrains) or
  # Check if string only contains one integer and its in the options
  def validate_input(input, options)
    return input if options == " "

    return unless options != " " && input !~ /\D/ && options.include?(input.to_i)

    input.to_i
  end

  def input_invalid(options)
    puts "\nInvalid input, please try again. "
    puts "Options are: #{options.join(", ")} " unless options == " "
  end

  # prints insturctions
  def display_help(input)
    return unless input.downcase == "help"

    puts help
    true
  end

  def help
    "Help instructions:\n\n"\
    "1. There are 9 cells, to place a mark in one of the cells input a number from 0 to 8;\n\n"\
    "2. Player X is always the frist one to play;\n"\
    "3. Players alternate turns, placing their marks (X or O) in cells there are not yet taken;\n\n"\
    "4. The objective is to get three of your marks in a row, either horizontally, vertically, or diagonally;\n\n"\
    "5. Plan your moves strategically to prevent your opponent from getting three in a row while also trying to"\
    " create your own winning combination;\n\n"\
    "6. Keep taking turns until one of the players achieves three marks in a row or all the cells on the grid are"\
    " filled;\n\n"
  end
end
