# frozen_string_literal: true

require "./lib/tic_tac_toe/game_play"
require "stringio"

RSpec.describe GamePlay do
  let(:instance) { described_class.new }

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

  # describe ".create_players" do
  #   context "Human vs Human game mode: " do
  #     it "creates 2 human players" do
  #       $stdin = StringIO.new("0")
  #       instance.set_game_mode
  #       $stdin = STDIN

  #       expect { instance.create_players }.to change { instance.player1.class }
  #         .to(Human).and change { instance.player2.class }.to(Human)
  #     end
  #   end

  #   context "Human vs Computer game mode: " do
  #     it "creates human and computer players" do
  #       $stdin = StringIO.new("1")
  #       instance.set_game_mode
  #       $stdin = STDIN

  #       expect { instance.create_players }.to change { instance.player1.class }
  #         .to(Human).and change { instance.player2.class }.to(Computer)
  #     end
  #   end

  #   context "Computer vs Computer game mode: " do
  #     it "creates 2 computer players" do
  #       $stdin = StringIO.new("2")
  #       instance.set_game_mode
  #       $stdin = STDIN

  #       expect { instance.create_players }.to change { instance.player1.class }
  #         .to(Computer).and change { instance.player2.class }.to(Computer)
  #     end
  #   end
  # end
end
