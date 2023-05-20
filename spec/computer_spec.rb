# frozen_string_literal: true

require "./lib/tic_tac_toe/computer"
require "./lib/tic_tac_toe/game"
require "./lib/tic_tac_toe/human"

RSpec.describe Computer do
  describe ".best_move" do
    context "use symbol X and level hard: " do
      let(:computer) { described_class.new("X", 2) }

      it "returns 4 if spot 4 is available" do
        board = %w[0 1 2 3 4 5 6 7 8]
        expect(computer.best_move(board)).to eq(4)
      end

      it "returns 8 as best_move for winning" do
        board = %w[X 1 O 3 X 5 6 7 8]
        expect(computer.best_move(board)).to eq(8)
      end

      it "returns 7 as best_move for winning" do
        board = %w[O X O 3 X 5 6 7 8]
        expect(computer.best_move(board)).to eq(7)
      end

      it "returns 6 as best_move for winning" do
        board = %w[0 1 X 3 X 5 6 O 8]
        expect(computer.best_move(board)).to eq(6)
      end

      it "returns 8 as best_move for defending" do
        board = %w[O 1 X 3 O X 6 7 8]
        expect(computer.best_move(board)).to eq(8)
      end

      it "returns corner spot 0" do
        board = %w[0 O 2 3 X 5 6 7 8]
        expect(computer.best_move(board)).to eq(0)
      end

      it "returns corner spot 6" do
        board = %w[X O O 3 O X 6 7 8]
        expect(computer.best_move(board)).to eq(6)
      end

      it "returns random best_move" do
        board = %w[X O O 3 O X 6 7 8]
        expect(computer.best_move(board)).to eq(6)
      end
    end

    context "use symbol O: " do
      let(:computer) { described_class.new("O", 2) }

      it "returns 7 as best_move for defending" do
        board = %w[O X 2 3 X O 6 7 8]
        expect(computer.best_move(board)).to eq(7)
      end

      it "returns corner spot 6" do
        board = %w[X O X 3 O 5 6 X 8]
        expect(computer.best_move(board)).to eq(6)
      end

      it "returns random best_move from available spots" do
        board = %w[O X O 3 X 5 X O X]
        available = [3, 5]
        expect(available).to include(computer.best_move(board))
      end
    end

    context "use symbol X and level easy: " do
      let(:computer) { described_class.new("X", 1) }

      it "returns random move from available spots" do
        board = %w[O X O 3 X 5 X O X]
        available = [3, 5]
        expect(available).to include(computer.best_move(board))
      end
    end
  end
end
