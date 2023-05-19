# frozen_string_literal: true

require "./lib/tic_tac_toe/computer"
require "./lib/tic_tac_toe/game"
require "./lib/tic_tac_toe/human"

RSpec.describe Computer do
  before do
    @symbol = %w[X O][rand(0..1)]
    @computer = Computer.new(@symbol)
  end

  describe ".symbol" do
    it "Returns computer's symbol" do
      expect(@computer.symbol).to eq @symbol
    end
  end

  describe ".levels" do
    it "returns available levels" do
      expect(@computer.levels).to eq({ 1 => "Easy", 2 => "Hard" })
    end
  end

  describe ".move" do
    context "win the game: " do
      before do
        @player1 = Human.new("X", Faker::Name.name)
        @player2 = Human.new("O", Faker::Name.name)
        @game = Game.new(@player1, @player2)
      end

      it "returns 4 if spot 4 is available" do
        expect(@computer.move(@game)).to eq(4)
      end

      it "returns 8 as move" do
        [0, 1, 4, 5].each { |n| @game.input_to_board(n) }
        expect(@computer.move(@game)).to eq(8)
      end
    end

    context "protect from loosing: " do
      before do
        @player1 = Human.new("X", Faker::Name.name)
        @player2 = Human.new("O", Faker::Name.name)
        @game = Game.new(@player1, @player2)
      end

      it "returns 8 as move" do
        [2, 0, 1, 4].each { |n| @game.input_to_board(n) }
        expect(@computer.move(@game)).to eq(8)
      end
    end
  end
end
