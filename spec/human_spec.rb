# frozen_string_literal: true

require "./lib/tic_tac_toe/human"
require "faker"

RSpec.describe Human do
  before do
    @name = Faker::Name.name
    @symbol = %w[X O][rand(0..1)]
    @human = Human.new(@symbol, @name)
  end

  describe ".name" do
    it "Returns human's name" do
      expect(@human.name).to eq @name
    end

    it "Returns default name" do
      human = Human.new(@symbol, "")
      expect(human.name).to eq "Player #{@symbol}"
    end
  end

  describe ".symbol" do
    it "Returns human's symbol" do
      expect(@human.symbol).to eq @symbol
    end
  end
end
