# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nine_gag/version'

Gem::Specification.new do |spec|
  spec.name          = "nine-gag"
  spec.version       = NineGag::VERSION
  spec.authors       = ["Dimas J. Taniawan"]
  spec.email         = ["dimazniawan@gmail.com"]

  spec.summary       = "9Gag API"
  spec.description   = "Unofficial 9Gag gem"
  spec.homepage      = "https://github.com/dimasjt/nine-gag"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "nokogiri"
  spec.add_dependency "rest-client"

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "minitest-reporters"
  spec.add_development_dependency "pry"
end
