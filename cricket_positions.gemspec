# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cricket_positions/version'

Gem::Specification.new do |spec|
  spec.name          = 'cricket_positions'
  spec.version       = CricketPositions::VERSION
  spec.authors       = ['Mike Butt']
  spec.email         = 'mjbutt@hotmail.co.uk'
  spec.summary       = 'A cricket positions library'
  spec.description   = 'Holds the positions on a cricket pitch and gives ability to query the position at a point'
  spec.homepage      = 'https://github.com/m1ckr1sk/CricketPositions'
  spec.licenses      = ['GNU3']
  spec.files         = `git ls-files -z`.split("\x0")
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']
  spec.add_development_dependency 'rspec', '~> 3.0'
end
