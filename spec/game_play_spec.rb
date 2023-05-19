# frozen_string_literal: true

require "./lib/tic_tac_toe/game_play"
require "stringio"

RSpec.describe GamePlay do
  let(:game_play_instance) { described_class.new }

  describe ".get_input" do
    it "returns input without if no options are given" do
      input = "Testing any input"
      $stdin = StringIO.new(input)

      expect(game_play_instance.get_input).to eq(input)
      $stdin = STDIN
    end

    it "returns name when name is given" do
      input = Faker::Name.name
      $stdin = StringIO.new(input)

      expect(game_play_instance.get_input).to eq(input)
      $stdin = STDIN
    end

    it "receives valid number and returns it as integer" do
      $stdin = StringIO.new("3")

      expect(game_play_instance.get_input([0, 1, 3])).to eq(3)
      $stdin = STDIN
    end

    it "receives invalid number and returns error message" do
      $stdin = StringIO.new("10")

      expect { game_play_instance.get_input([1, 2, 3]) }.to output(include("Invalid")).to_stdout
      $stdin = STDIN
    end

    it "exits game if input exit" do
      $stdin = StringIO.new("exit")

      expect { game_play_instance.get_input([1, 2, 3]) }.to raise_error(SystemExit, "Exiting the game...")
      $stdin = STDIN
    end

    it "exits game if input quit" do
      $stdin = StringIO.new("quit")

      expect { game_play_instance.get_input([1, 2, 3]) }.to raise_error(SystemExit, "Exiting the game...")
      $stdin = STDIN
    end

    it "returns help instructions if input help" do
      $stdin = StringIO.new("help ")

      expect { game_play_instance.get_input([1, 2, 3]) }.to output(include("Help instructions")).to_stdout
      $stdin = STDIN
    end
  end
end
