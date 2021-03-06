# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sinatra/avro/version'

Gem::Specification.new do |spec|
  spec.name          = "sinatra-avro"
  spec.version       = Sinatra::Avro::VERSION
  spec.authors       = ["Daniel Schierbeck"]
  spec.email         = ["dasch@zendesk.com"]
  spec.summary       = %q{A Sinatra plugin that allows encoding requests and responses using Apache Avro}
  spec.homepage      = "https://github.com/dasch/sinatra-avro"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "avro_turf", "~> 0.2.0"
  spec.add_dependency "sinatra"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.2.0"
  spec.add_development_dependency "sinatra-contrib", "~> 1.4.2"
end
