# frozen_string_literal: true

require "./lib/tic_tac_toe/human"
require "faker"
require "stringio"

RSpec.describe Human do
  let(:human_instance) { described_class.new(%w[X O][rand(0..1)], Faker::Name.name) }

  describe ".get_input" do
    it "returns input without if no options are given" do
      input = "Testing any input"
      $stdin = StringIO.new(input)

      expect(human_instance.get_input).to eq(input)
      $stdin = STDIN
    end

    it "returns name when name is given" do
      input = Faker::Name.name
      $stdin = StringIO.new(input)

      expect(human_instance.get_input).to eq(input)
      $stdin = STDIN
    end

    it "receives valid number and returns it as integer" do
      $stdin = StringIO.new("3")

      expect(human_instance.get_input([0, 1, 3])).to eq(3)
      $stdin = STDIN
    end

    it "receives invalid number and returns error message" do
      $stdin = StringIO.new("10")

      expect { human_instance.get_input([1, 2, 3]) }.to output(include("Invalid")).to_stdout
      $stdin = STDIN
    end

    it "exits game if input exit" do
      $stdin = StringIO.new("exit")

      expect { human_instance.get_input([1, 2, 3]) }.to raise_error(SystemExit, "Exiting the game...")
      $stdin = STDIN
    end

    it "exits game if input quit" do
      $stdin = StringIO.new("quit")

      expect { human_instance.get_input([1, 2, 3]) }.to raise_error(SystemExit, "Exiting the game...")
      $stdin = STDIN
    end

    it "returns help instructions if input help" do
      $stdin = StringIO.new("help ")

      expect { human_instance.get_input([1, 2, 3]) }.to output(include("Help instructions")).to_stdout
      $stdin = STDIN
    end
  end

  describe ".name" do
    it "sets human name" do
      name = Faker::Name.name
      expect { human_instance.name = name }.to change { human_instance.name }.to(name)
    end
  end
end
