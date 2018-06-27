
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "url_verifier/version"

Gem::Specification.new do |spec|
  spec.name          = "url_verifier"
  spec.version       = UrlVerifier::VERSION
  spec.authors       = ["Adam Booth"]
  spec.email         = ["4rlm@protonmail.ch"]

  spec.summary       = %q{Reserving Namespace for Gem in Development.}
  spec.description   = %q{Reserving Namespace for Gem in Development. - Coming Soon.}
  spec.homepage      = 'https://github.com/4rlm/url_verifier'
  spec.license       = "MIT"

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  # spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
  #   `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  # end

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '~> 2.5.1'
  spec.add_dependency 'activesupport', '~> 5.2', '>= 5.2.0'

  spec.add_dependency "utf8_sanitizer", "~> 2.0"
  spec.add_dependency "crm_formatter", "~> 2.4"

  spec.add_development_dependency 'bundler', '~> 1.16', '>= 1.16.2'
  spec.add_development_dependency 'byebug', '~> 10.0', '>= 10.0.2'
  spec.add_development_dependency 'class_indexer', '~> 0.3.0'
  spec.add_development_dependency 'irbtools', '~> 2.2', '>= 2.2.1'
  spec.add_development_dependency 'pry', '~> 0.11.3'
  spec.add_development_dependency 'rake', '~> 12.3', '>= 12.3.1'
  spec.add_development_dependency 'rspec', '~> 3.7'
  spec.add_development_dependency 'rubocop', '~> 0.56.0'
  spec.add_development_dependency 'ruby-beautify', '~> 0.97.4'
end
