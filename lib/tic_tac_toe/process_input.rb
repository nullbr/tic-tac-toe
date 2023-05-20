# frozen_string_literal: true

# Validate data that is being inputed
class ProcessInput
  def initialize; end

  def capture_input(options = " ")
    input = gets.chomp.strip

    return if display_help(input)

    exit_game(input) || validate_input(input, options) || input_invalid(options)
  end

  private

  def exit_game(input)
    return unless %w[quit end exit].include?(input.downcase)

    puts "\nGlad to have you, see you later!"
    abort("Exiting the game...")
  end

  # Returns input based on options given
  def validate_input(input, options)
    if options == " "
      input
    # Check if string only contains one integer and its in the options
    elsif input !~ /\D/ && options.include?(input.to_i)
      input.to_i
    elsif options.include?(input.downcase)
      input.downcase
    elsif options.include?(input.upcase)
      input.upcase
    end
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
    "2. Player X is always the first one to play;\n\n"\
    "3. Players alternate turns, placing their marks (X or O) in cells that are not yet taken;\n\n"\
    "4. The goal is to get three of your marks in a row, either horizontally, vertically, or diagonally;\n\n"\
    "5. Plan your moves strategically to prevent your opponent from getting three in a row while also trying to"\
    " create your own winning combination;\n\n"\
    "6. Keep taking turns until one of the players achieves three marks in a row or all the cells on the grid are"\
    " filled;\n\n"
  end
end
