# frozen_string_literal: true

require_relative 'lib/rubocop/rbs/version'

Gem::Specification.new do |spec|
  spec.name = 'rubocop-rbs'
  spec.version = RuboCop::Rbs::VERSION
  spec.authors = ['Mattia Roccoberton']
  spec.email = ['mat@blocknot.es']

  spec.summary = 'RuboCop RBS'
  spec.description = 'RuboCop cops to check RBS signatures'
  spec.homepage = 'https://github.com/blocknotes/rubocop-rbs'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 3.0.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/blocknotes/rubocop-rbs'

  spec.files         = Dir['{config,lib}/**/*', 'LICENSE.txt', 'README.md']
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'rbs'
  spec.add_runtime_dependency 'rubocop'
end
