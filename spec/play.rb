# frozen_string_literal: true

require "./lib/tic_tac_toe/play"

RSpec.describe Play do
  describe "#display_the_board" do
    it "displays the initial board" do
      play = Play.new
      board = " 0 | 1 | 2\n===+===+===\n 3 | 4 | 5\n===+===+===\n 6 | 7 | 8\n"
      expect(play.display_the_board).to eq(board)
    end
  end
end
