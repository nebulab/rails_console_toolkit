
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "rails_console_toolkit/version"

Gem::Specification.new do |spec|
  spec.name          = "rails_console_toolkit"
  spec.version       = RailsConsoleToolkit::VERSION
  spec.authors       = ["Elia Schito"]
  spec.email         = ["elia@schito.me"]

  spec.summary       = %q{Configurable Rails Console Helpers}
  spec.description   = %q{Find records faster, add custom helpers, improve your console life by 100%.}
  spec.homepage      = "https://github.com/nebulab/rails_console_toolkit#readme"
  spec.license       = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/nebulab/rails_console_toolkit"
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", '>= 4'

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
