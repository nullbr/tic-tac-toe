# frozen_string_literal: true

require "./lib/tic_tac_toe/human"
require "faker"
require "stringio"

RSpec.describe Human do
  let(:human_instance) { described_class.new(%w[X O][rand(0..1)], Faker::Name.name) }

  describe ".get_input" do
    # it "outputs to stdout prompt given in the block" do
    #   $stdin = StringIO.new("test")
    #   prompt = "Choose a spot [0-8]:\n"
    #   expect { human_instance.get_input { puts prompt } }.to output(prompt).to_stdout
    #   $stdin = STDIN
    # end

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
  end
end
