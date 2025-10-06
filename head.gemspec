# frozen_string_literal: true

require_relative 'lib/head/version'

Gem::Specification.new do |spec|
  spec.name = 'head'
  spec.version = Head::VERSION
  spec.authors = ['halo']
  spec.email = ['github@posteo.org']

  spec.summary = 'A simple, opinionated navigation menu ViewComponent'
  spec.description = 'With sidebars that work well on all screen widths.'
  spec.homepage = 'https://github.com/halo/head'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 3.4'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/halo/head'
  spec.metadata['changelog_uri'] = 'https://github.com/halo/halo/blob/main/CHANGELOG.md'

  spec.files = Dir['CHANGELOG.md', 'LICENSE.txt', 'README.md',
                   'app/**/*', 'lib/**/*', 'config/**/*'] & `git ls-files -z`.split("\0")

  spec.require_paths = ['lib']

  spec.add_dependency 'actionview' # Needed by `view_component`
  spec.add_dependency 'calls'
  spec.add_dependency 'countries'
  spec.add_dependency 'dry-initializer'
  spec.add_dependency 'holidays'
  spec.add_dependency 'importmap-rails'
  spec.add_dependency 'view_component'

  spec.metadata['rubygems_mfa_required'] = 'true'
end
