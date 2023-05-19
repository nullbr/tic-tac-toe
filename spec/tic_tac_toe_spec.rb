# frozen_string_literal: true

require "./lib/tic_tac_toe/game"

RSpec.describe Game do
  before do
    @player1 = "Bruno"
    @player2 = "Giu"
    @game = Game.new(@player1, @player2)
  end

  describe ".input_to_board" do
    context "returns true when user enters " do
      it "valid spot 2" do
        expect(@game.input_to_board("2")).to be_truthy
      end

      it "valid spot 7" do
        expect(@game.input_to_board("7")).to be_truthy
      end

      it "valid spot integer" do
        expect(@game.input_to_board(3)).to be_truthy
      end
    end

    context "returns false when user enters: " do
      it "a letter" do
        expect(@game.input_to_board("a")).to be_falsey
      end

      it "invalid spot string" do
        expect(@game.input_to_board("10")).to be_falsey
      end

      it "invalid spot integer" do
        expect(@game.input_to_board(15)).to be_falsey
      end

      it "spot taken" do
        @game.input_to_board("6")
        expect(@game.input_to_board("6")).to be_falsey
      end
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

  describe ".game_is_over?" do
    context "started game: " do
      it "returns false if board is empty" do
        expect(@game.game_is_over?).to be_falsey
        expect(@game.win_type).to eq nil
      end

      it "returns false if there are two inputs" do
        @game.input_to_board("3")
        @game.input_to_board("5")
        expect(@game.game_is_over?).to be_falsey
        expect(@game.win_type).to eq nil
      end

      it "returns false if there are 4 inputs" do
        4.times { |n| @game.input_to_board(n) }
        expect(@game.game_is_over?).to be_falsey
        expect(@game.win_type).to eq nil
      end
    end

    context "win on diagonal: " do
      it "returns true if X inputs on 0, 4 and 8" do
        [0, 1, 4, 5, 8].each { |n| @game.input_to_board(n) }
        expect(@game.game_is_over?).to be_truthy
        expect(@game.win_type).to eq "diagonal"
      end

      it "returns true if O inputs on 0, 4 and 8" do
        [1, 0, 5, 4, 2, 8].each { |n| @game.input_to_board(n) }
        expect(@game.game_is_over?).to be_truthy
        expect(@game.win_type).to eq "diagonal"
      end

      it "returns true if X inputs on 2, 4 and 6" do
        [2, 0, 4, 3, 6].each { |n| @game.input_to_board(n) }
        expect(@game.game_is_over?).to be_truthy
        expect(@game.win_type).to eq "diagonal"
      end

      it "returns true if O inputs on 2, 4 and 6" do
        [1, 2, 5, 4, 3, 6].each { |n| @game.input_to_board(n) }
        expect(@game.game_is_over?).to be_truthy
        expect(@game.win_type).to eq "diagonal"
      end
    end

    context "win on vertical: " do
      it "returns true if X inputs on 0, 3 and 6" do
        [0, 1, 3, 4, 6].each { |n| @game.input_to_board(n) }
        expect(@game.game_is_over?).to be_truthy
        expect(@game.win_type).to eq "vertical"
      end

      it "returns true if X inputs on 1, 4 and 7" do
        [1, 3, 4, 6, 7].each { |n| @game.input_to_board(n) }
        expect(@game.game_is_over?).to be_truthy
        expect(@game.win_type).to eq "vertical"
      end

      it "returns true if X inputs on 2, 5 and 8" do
        [2, 1, 5, 4, 8].each { |n| @game.input_to_board(n) }
        expect(@game.game_is_over?).to be_truthy
        expect(@game.win_type).to eq "vertical"
      end
    end

    context "win on horizontal: " do
      it "returns true if X inputs on 0, 1 and 2" do
        [0, 5, 1, 4, 2].each { |n| @game.input_to_board(n) }
        expect(@game.game_is_over?).to be_truthy
        expect(@game.win_type).to eq "horizontal"
      end

      it "returns true if X inputs on 3, 4 and 5" do
        [3, 1, 4, 6, 5].each { |n| @game.input_to_board(n) }
        expect(@game.game_is_over?).to be_truthy
        expect(@game.win_type).to eq "horizontal"
      end

      it "returns true if X inputs on 6, 7 and 8" do
        [6, 1, 7, 4, 8].each { |n| @game.input_to_board(n) }
        expect(@game.game_is_over?).to be_truthy
        expect(@game.win_type).to eq "horizontal"
      end
    end

    describe ".next_player" do
      it "returns player 2" do
        player2 = "Bruno"
        game = Game.new("Giu", player2)
        expect(game.next_player).to be(player2)
      end
    end

    describe ".whose_turn" do
      it "returns initial player" do
        expect(@game.whose_turn).to eq @player1
      end

      it "returns player 2 after 3 moves" do
        @game.input_to_board(1)
        @game.input_to_board(2)
        @game.input_to_board(7)
        expect(@game.whose_turn).to eq @player2
      end
    end

    describe ".winner" do
      it "returns player 1 as winner" do
        [3, 1, 4, 6, 5].each { |n| @game.input_to_board(n) }
        @game.game_is_over?
        expect(@game.winner).to eq @player1
      end

      it "returns player 2 as winner" do
        [1, 2, 5, 4, 3, 6].each { |n| @game.input_to_board(n) }
        @game.game_is_over?
        expect(@game.winner).to eq @player2
      end
    end
  end
end
