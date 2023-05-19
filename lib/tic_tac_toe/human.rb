# frozen_string_literal: true

require_relative "player"

# Class definition for human player
class Human < Player
  attr_accessor :name

  def initialize(symbol, name = "")
    super(symbol)
    @name = name == "" ? "Player #{symbol}" : name
  end

  def get_input(options = " ")
    input = gets.chomp.strip

    if %w[quit end exit].include?(input.downcase)
      abort("Exiting the game...")

    # prints insturctions
    elsif input.downcase == "help"
      puts help

    # Breaks if there are no options (no constrains)
    elsif options == " "
      input

    # Check if string only contains one integer and its the correct type
    elsif options != " " && input !~ /\D/ && options.include?(input.to_i)
      input.to_i

    # Ask for a valid input type
    else
      puts "Invalid input, please try again. "
      puts "Options are: #{options.join(", ")} " unless options == " "
    end
  end

  def help
    "Help instructions:\n"\
    "1. There are 9 cells, to place a mark in one of the cells input a number from 0 to 8;\n"\
    "2. Player X is always the frist one to play;\n"\
    "3. Players alternate turns, placing their marks (X or O) in cells there are not yet taken;\n"\
    "4. The objective is to get three of your marks in a row, either horizontally, vertically, or diagonally;\n"\
    "5. Plan your moves strategically to prevent your opponent from getting three in a row while also trying to"\
    " create your own winning combination;\n"\
    "6. Keep taking turns until one of the players achieves three marks in a row or all the cells on the grid are"\
    " filled;\n"
  end
end
