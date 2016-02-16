# -*- encoding: utf-8 -*-

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vagrant-delphix/version'

Gem::Specification.new do |gem|
  gem.name          = 'vagrant-delphix'
  gem.version       = VagrantPlugins::DelphixEngine::VERSION
  gem.authors       = ['Michael Kuehl']
  gem.email         = ['michael.kuehl@delphix.com']
  gem.description   = %q{A Vagrant plugin that interacts with the Delphix Engine}
  gem.summary       = gem.description
  gem.license       = 'MIT'

  gem.files         = `git ls-files`.split($/)
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_development_dependency 'bundler', '~> 1.3'
  gem.add_development_dependency 'rake'

  gem.add_dependency 'delphix_rb', '~> 1.1.1'
end
