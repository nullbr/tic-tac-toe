# frozen_string_literal: true

require "./lib/tic_tac_toe/game_play"
require "stringio"

RSpec.describe GamePlay do
  let(:instance) { described_class.new }

  describe ".get_input" do
    it "returns input without if no options are given" do
      input = "Testing any input"
      $stdin = StringIO.new(input)

      expect(instance.get_input).to eq(input)
      $stdin = STDIN
    end

    it "returns name when name is given" do
      input = Faker::Name.name
      $stdin = StringIO.new(input)

      expect(instance.get_input).to eq(input)
      $stdin = STDIN
    end

    it "receives valid number and returns it as integer" do
      $stdin = StringIO.new("3")

      expect(instance.get_input([0, 1, 3])).to eq(3)
      $stdin = STDIN
    end

    it "puts error message and returns nil if input is invalid" do
      $stdin = StringIO.new("10")
      result = "non nil"

      expect do
        result = instance.get_input([1, 2, 3])
      end.to output(include("Invalid")).to_stdout

      expect(result).to be_nil

      $stdin = STDIN
    end

    it "exits game if input exit" do
      $stdin = StringIO.new("exit")

      expect { instance.get_input([1, 2, 3]) }.to raise_error(SystemExit, "Exiting the game...")
      $stdin = STDIN
    end

    it "exits game if input quit" do
      $stdin = StringIO.new("quit")

      expect { instance.get_input([1, 2, 3]) }.to raise_error(SystemExit, "Exiting the game...")
      $stdin = STDIN
    end

    it "puts help instructions and returns nil if input help" do
      $stdin = StringIO.new("help ")
      result = "non nil"

      expect do
        result = instance.get_input([1, 2, 3])
      end.to output(include("Help instructions")).to_stdout

      expect(result).to be_nil

      $stdin = STDIN
    end
  end

  describe ".set_game_mode" do
    it "sets game mode a 0" do
      $stdin = StringIO.new("0")

      expect(instance.set_game_mode).to eq(0)
      $stdin = STDIN
    end

    it "continues to ask for valid input until user enters valid" do
      $stdin = StringIO.new("4")
      expect { instance.set_game_mode }.to raise_error(NoMethodError)
      $stdin = STDIN
    end
  end

  describe ".create_players" do
    context "Human vs Human game mode: " do
      it "creates 2 human players" do
        $stdin = StringIO.new("0")
        instance.set_game_mode
        $stdin = STDIN

        expect { instance.create_players }.to change { instance.player1.class }
          .to(Human).and change { instance.player2.class }.to(Human)
      end
    end

    context "Human vs Computer game mode: " do
      it "creates human and computer players" do
        $stdin = StringIO.new("1")
        instance.set_game_mode
        $stdin = STDIN

        expect { instance.create_players }.to change { instance.player1.class }
          .to(Human).and change { instance.player2.class }.to(Computer)
      end
    end

    context "Computer vs Computer game mode: " do
      it "creates 2 computer players" do
        $stdin = StringIO.new("2")
        instance.set_game_mode
        $stdin = STDIN

        expect { instance.create_players }.to change { instance.player1.class }
          .to(Computer).and change { instance.player2.class }.to(Computer)
      end
    end
  end
end
