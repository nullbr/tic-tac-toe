# frozen_string_literal: true

require "./lib/tic_tac_toe/game"

RSpec.describe Game do
  describe ".input_to_board" do
    before do
      @game = Game.new("Bruno", "Giu")
    end
    context "returns true when user enters " do
      it "valid spot 2" do
        expect(@game.input_to_board("2")).to be_truthy
      end

      it "valid spot 7" do
        expect(@game.input_to_board("7")).to be_truthy
      end
    end

    context "returns false when user enters " do
      it "a letter" do
        expect(@game.input_to_board("a")).to be_falsey
      end

      it "invalid spot" do
        expect(@game.input_to_board("10")).to be_falsey
      end

      it "spot taken" do
        @game.input_to_board("6")
        expect(@game.input_to_board("6")).to be_falsey
      end
    end
  end

  describe ".next_player" do
    it "returns player 2 if no one has played" do
      player2 = "Bruno"
      game = Game.new("Giu", player2)
      expect(game.next_player).to be(player2)
    end
  end

  describe ".display_the_board" do
    it "display an empty board" do
      game = Game.new("Bruno", "Giu")
      empty_board = " 0 | 1 | 2\n===+===+===\n 3 | 4 | 5\n===+===+===\n 6 | 7 | 8\n"
      expect(game.display_the_board).to eq(empty_board)
    end

    it "display game, after two moves" do
      game = Game.new("Bruno", "Giu")
      game.input_to_board("1")
      game.input_to_board("3")
      board = " 0 | X | 2\n===+===+===\n O | 4 | 5\n===+===+===\n 6 | 7 | 8\n"
      expect(game.display_the_board).to eq(board)
    end
  end

  describe ".tied?" do
    it "returns true if game is tied" do
      game = Game.new("Bruno", "Giu")
      game.board.each { |spot| game.input_to_board(spot) }
      expect(game.tied?).to be_truthy
    end

    it "returns false if game is not tied" do
      game = Game.new("Bruno", "Giu")
      game.input_to_board("1")
      expect(game.tied?).to be_falsey
    end
  end

  describe ".diagonal" do
    context "check if game won diagonaly: " do
      it "returns true if 1, 4, 8 is X" do
      end
    end
  end

  describe ".game_not_over" do
    context "returns true has not finished, else returns false" do
      it "not won" do
        game = Game.new("Bruno", "Giu")
        expect(game.game_not_over?).to be_truthy
      end

      it "win horizontaly" do
        game = Game.new("Bruno", "Giu")
        game.input_to_board(1, 1)
        game.input_to_board(2, 2)
        game.input_to_board(1, 2)
        game.input_to_board(3, 1)
        game.input_to_board(1, 3)
        # puts game.display_the_board
        expect(game.game_not_over?).to_not be_truthy
      end

      it "win diagonally" do
        game = Game.new("Bruno", "Giu")
        game.input_to_board(1, 1)
        game.input_to_board(2, 2)
        game.input_to_board(1, 2)
        game.input_to_board(3, 1)
        game.input_to_board(2, 3)
        game.input_to_board(1, 3)
        # puts game.display_the_board
        expect(game.game_not_over?).to_not be_truthy
      end

      it "win diagonally in the other direction" do
        game = Game.new("Bruno", "Giu")
        game.input_to_board(1, 1)
        game.input_to_board(2, 1)
        game.input_to_board(2, 2)
        game.input_to_board(3, 1)
        game.input_to_board(3, 3)
        # puts game.display_the_board
        expect(game.game_not_over?).to_not be_truthy
      end

      it "win verticaly" do
        game = Game.new("Bruno", "Giu")
        game.input_to_board(1, 2)
        game.input_to_board(2, 1)
        game.input_to_board(2, 2)
        game.input_to_board(3, 1)
        game.input_to_board(3, 2)
        # puts game.display_the_board
        expect(game.game_not_over?).to_not be_truthy
      end
    end
  end
end
