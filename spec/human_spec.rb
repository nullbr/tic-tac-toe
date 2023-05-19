# frozen_string_literal: true

require "./lib/tic_tac_toe/human"

RSpec.describe Human do
  let(:human_instance) { described_class.new(%w[X O][rand(0..1)], Faker::Name.name) }

  describe ".name" do
    it "sets human name" do
      name = Faker::Name.name
      expect { human_instance.name = name }.to change { human_instance.name }.to(name)
    end
  end
end
