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
  # s.files         = Dir["lib/**/*", "spec/**/*", "bin/*"]
  s.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  s.bindir        = "exe"
  s.executables   = s.files.grep(%r{^exe/}) { |f| File.basename(f) }
  # s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]
  s.homepage      = 'http://rubygems.org/gems/sesh'
  s.license       = 'GNU GPLv3'

  s.add_development_dependency 'bundler', '~> 1.10'
  s.add_development_dependency 'rake', '~> 10.0'
  s.add_development_dependency 'rspec', '~> 3.3'

  s.add_dependency 'tmuxinator', '~> 0.6.9'
  s.add_dependency 'deep_merge', '~> 1.0'
  s.add_dependency 'awesome_print', '~> 1.6'
  s.add_dependency 'colorize', '~> 0.7.7'
  s.add_dependency 'open4', '~> 1.3.4'
end
