# frozen_string_literal: true

require "./lib/tic_tac_toe/computer"

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
end
