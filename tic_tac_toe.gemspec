# frozen_string_literal: true

require_relative "lib/tic_tac_toe/version"

Gem::Specification.new do |spec|
  spec.name = "tic_tac_toe"
  spec.version = TicTacToe::VERSION
  spec.authors = ["Bruno Leite"]
  spec.email = ["bmarianoleite3@gmail.com"]

  spec.summary = "Simple Tic Tac Toe Game"
  spec.description = "Command line tic tac toe game."
  spec.homepage = "https://github.com/nullbr/tic-tac-toe"
  spec.required_ruby_version = ">= 3.1.2"

  spec.metadata["homepage_uri"] = spec.homepage

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
