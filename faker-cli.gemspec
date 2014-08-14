# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'faker/cli/version'

Gem::Specification.new do |spec|
  spec.name          = "faker-cli"
  spec.version       = Faker::Cli::VERSION
  spec.authors       = ["Tobias Witt"]
  spec.email         = ["tobias.witt@hhu.de"]
  spec.summary       = %q{Command line interface for the faker gem}
  spec.description   = %q{This tool helps to create a json array of json objects having certain fields and faked values in them.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "faker", "~> 1.4.2"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
