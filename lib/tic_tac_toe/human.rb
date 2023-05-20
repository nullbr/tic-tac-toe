# frozen_string_literal: true

require_relative "player"
require_relative "process_input"

# Class definition for human player
class Human < Player
  attr_accessor :name

  def initialize(symbol, name = "")
    name = name == "" ? "Player #{symbol}" : name
    super(symbol, name)
  end

  # Get human choice of spot
  def move(board)
    puts "\nIt's #{name}'s turn."
    print "Enter [0-8]: "

    spot = capture_input(available_spots(board)) until spot
    spot
  end

  private

  # Helper method to process user input cleanly
  def capture_input(options = " ")
    ProcessInput.new.capture_input(options)
  end
end
