# frozen_string_literal: true

require "./lib/tic_tac_toe/process_input"
require "stringio"

RSpec.describe ProcessInput do
  let(:instance) { described_class.new }

  it "returns input without if no options are given" do
    input = "Testing any input"
    $stdin = StringIO.new(input)

    expect(instance.capture_input).to eq(input)
    $stdin = STDIN
  end

  it "returns name when name is given" do
    input = Faker::Name.name
    $stdin = StringIO.new(input)

    expect(instance.capture_input).to eq(input)
    $stdin = STDIN
  end

  it "receives valid number and returns it as integer" do
    $stdin = StringIO.new("3")

    expect(instance.capture_input([0, 1, 3])).to eq(3)
    $stdin = STDIN
  end

  it "receives valid string and returns it" do
    $stdin = StringIO.new("X")

    expect(instance.capture_input(%w[X O])).to eq("X")
    $stdin = STDIN
  end

  it "puts error message and returns nil if input is invalid" do
    $stdin = StringIO.new("10")
    result = "non nil"

    expect do
      result = instance.capture_input([1, 2, 3])
    end.to output(include("Invalid")).to_stdout

    expect(result).to be_nil

    $stdin = STDIN
  end

  it "exits game if input exit" do
    $stdin = StringIO.new("exit")

    expect { instance.capture_input([1, 2, 3]) }.to raise_error(SystemExit, "Exiting the game...")
    $stdin = STDIN
  end

  it "exits game if input quit" do
    $stdin = StringIO.new("quit")

    expect { instance.capture_input([1, 2, 3]) }.to raise_error(SystemExit, "Exiting the game...")
    $stdin = STDIN
  end

  it "puts help instructions and returns nil if input help" do
    $stdin = StringIO.new("help ")
    result = "non nil"

    expect do
      result = instance.capture_input([1, 2, 3])
    end.to output(include("Help instructions")).to_stdout

    expect(result).to be_nil

    $stdin = STDIN
  end
end
