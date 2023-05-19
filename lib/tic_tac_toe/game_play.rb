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

  SYMBOLS = %w[X O].freeze

  def initialize; end

  def setup
    # Clear screen before starting game
    clear_screen
    # initialize all variables
    @game_mode = nil
    @player1 = nil
    @player2 = nil
    @available_symbols = SYMBOLS
    # Welcome
    welcome_message
    # Get game mode
    set_game_mode
    # Create players
    set_players
    # create game
    @game = Game.new(@player1, @player2)
  end

  def start_game
    setup
    # loop through until the game was won or tied
    until @game.game_is_over?
      clear_screen
      puts @game.display_the_board

      capture_human_spot

      # eval_board unless game_not_over?
    end

    end_game
  end

  def welcome_message
    puts "Tic Tac Toe".art
    puts "\t\t\t\t\t   by Bruno Leite"
    puts "\nLets Play!\n"
  end

  def set_game_mode
    puts "\nChoose a game mode (0, 1 or 3):\n" \
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
    print "\nEnter a name for player #{num}: "
    name = capture_input

    if @available_symbols.count > 1
      print "\nWould you like to play as #{@available_symbols.first} or #{@available_symbols.last}? "
      symbol = capture_input(@available_symbols) until symbol
    else
      symbol = @available_symbols.first
    end

    @available_symbols.delete(symbol)

    Human.new(symbol, name, SYMBOLS.index(symbol).zero?)
  end

  # Get human choice of spot
  def capture_human_spot
    spot = @game.whose_turn.move(@game.available_spots)

    @game.input_to_board(spot)
  end

  # Shows game winner if there is one and offers rematch
  def end_game
    clear_screen
    puts @game.display_the_board
    puts "\nGame over!"

    (winner = @game.winner) ? puts("\nAnd the Winner is #{winner.name}!!!") : puts("\nNobody won :(")

    print "\nWould you like to play again? [y/n] "
    choice = capture_input(%w[y n]) until choice
    choice == "y" ? start_game : abort("\nExiting the game...")
  end

  # Helper method to process user input cleanly
  def capture_input(options = " ")
    ProcessInput.new.capture_input(options)
  end

  # Helper method to clear the screen
  def clear_screen
    system "clear"
  end
end
