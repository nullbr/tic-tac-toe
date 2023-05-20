# frozen_string_literal: true

require "./lib/tic_tac_toe/computer"
require "./lib/tic_tac_toe/game"
require "./lib/tic_tac_toe/human"

RSpec.describe Computer do
  before do
    @symbol = "X"
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
    it "returns 4 if spot 4 is available" do
      board = %w[0 1 2 3 4 5 6 7 8]
      expect(@computer.move(board)).to eq(4)
    end

    it "returns 8 as move for winning" do
      board = %w[X 1 O 3 X 5 6 7 8]
      expect(@computer.move(board)).to eq(8)
    end

    it "returns 7 as move for winning" do
      board = %w[O X O 3 X 5 6 7 8]
      expect(@computer.move(board)).to eq(7)
    end

    it "returns 6 as move for winning" do
      board = %w[0 1 X 3 X 5 6 O 8]
      expect(@computer.move(board)).to eq(6)
    end

    it "returns 8 as move for defending" do
      board = %w[O 1 X 3 O X 6 7 8]
      expect(@computer.move(board)).to eq(8)
    end

    it "returns 7 as move for defending" do
      computer = Computer.new("O")
      board = %w[O X 2 3 X O 6 7 8]
      expect(computer.move(board)).to eq(7)
    end

    it "returns corner spot 0" do
      board = %w[0 O 2 3 X 5 6 7 8]
      expect(@computer.move(board)).to eq(0)
    end

    it "returns corner spot 6" do
      board = %w[X O O 3 O X 6 7 8]
      expect(@computer.move(board)).to eq(6)
    end
  end
end
