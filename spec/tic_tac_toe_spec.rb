# frozen_string_literal: true

require "./lib/tic_tac_toe/game"

RSpec.describe Game do
  before do
    @game = Game.new("Bruno", "Giu")
  end
  describe ".input_to_board" do
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
    it "returns false if game is not tied" do
      @game.input_to_board("8")
      @game.tied?
      expect(@game.win_type).to eq("")
    end

    it "returns true if game is tied" do
      9.times { |spot| @game.input_to_board(spot.to_s) }
      @game.tied?
      expect(@game.win_type).to eq("Tie")
    end
  end

  describe ".horizontal_win?" do
    context "check if game won diagonaly: " do
      it "expects game_type to be empty" do
        [1, 2, 3, 4, 5].each { |spot| @game.input_to_board(spot.to_s) }
        @game.horizontal_win?
        expect(@game.win_type).to eq("")
      end

      it "expects game type to be vertical with x on 0, 1, 2" do
        [0, 5, 2, 4, 1].each { |spot| @game.input_to_board(spot.to_s) }
        @game.horizontal_win?
        expect(@game.win_type).to eq("Horizontal")
      end

      it "expects game type to be vertical with O on 6, 7, 8" do
        [0, 6, 3, 7, 5, 8].each { |spot| @game.input_to_board(spot.to_s) }
        @game.horizontal_win?
        expect(@game.win_type).to eq("Horizontal")
      end
    end
  end

  describe ".vertical_win?" do
    context "check if game won diagonaly: " do
      it "expects game_type to be empty" do
        [1, 2, 3, 4, 5].each { |spot| @game.input_to_board(spot.to_s) }

        expect(@game.vertical_win?).to be_falsey
        expect(@game.win_type).to eq("")
      end

      it "expects game type to be vertical with x on 0, 3, 6" do
        [0, 1, 3, 4, 6].each { |spot| @game.input_to_board(spot.to_s) }
        @game.vertical_win?
        expect(@game.win_type).to eq("Vertical")
      end

      it "expects game type to be vertical with O on 1, 4, 7" do
        [0, 1, 3, 4, 6].each { |spot| @game.input_to_board(spot.to_s) }
        @game.vertical_win?
        expect(@game.win_type).to eq("Vertical")
      end
    end
  end

  describe ".diagonal_win" do
    context "check if game won diagonaly: " do
      it "expects game_type to be empty" do
        [1, 2, 3, 4, 8].each { |spot| @game.input_to_board(spot.to_s) }
        @game.diagonal_win?
        expect(@game.win_type).to eq("")
      end

      it "expects game type to be diagonal with x on 0, 4, 8" do
        [0, 1, 4, 5, 8].each { |spot| @game.input_to_board(spot.to_s) }
        @game.diagonal_win?
        expect(@game.win_type).to eq("Diagonal")
      end

      it "expects game type to be diagonal with O on 2, 4, 6" do
        [0, 2, 5, 4, 7, 6].each { |spot| @game.input_to_board(spot.to_s) }
        @game.diagonal_win?
        expect(@game.win_type).to eq("Diagonal")
      end
    end
  end

  describe ".game_is_over?" do
    context "Returns true game has finished, else returns false: " do
      it "is not over" do
        expect(game.game_is_over?).to be_falsey
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
