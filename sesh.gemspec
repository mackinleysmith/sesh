# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "sesh/version"

Gem::Specification.new do |s|
  s.name          = 'sesh'
  s.version       = Sesh::VERSION
  s.date          = '2015-03-17'
  s.summary       = "Sesh"
  s.description   = "Remote background sessions powered by tmux and tmuxinator."
  s.authors       = ["MacKinley Smith"]
  s.email         = 'smithmackinley@gmail.com'
  s.files         = Dir["lib/**/*", "spec/**/*", "bin/*"]
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]
  s.homepage      = 'http://rubygems.org/gems/sesh'
  s.license       = 'GNU GPLv3'

  s.add_dependency "tmuxinator", '~> 0.6.9'
end
