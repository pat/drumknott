# coding: utf-8
Gem::Specification.new do |spec|
  spec.name          = "drumknott"
  spec.version       = "0.3.0"
  spec.authors       = ["Pat Allan"]
  spec.email         = ["pat@freelancing-gods.com"]

  spec.summary       = %q{Jekyll content uploader for Drumknott's search service.}
  spec.description   = %q{Takes each of your compiled Jekyll pages and uploads them to Drumknott.}
  spec.homepage      = "https://github.com/pat/drumknott"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'faraday'
  spec.add_runtime_dependency 'json'
  spec.add_runtime_dependency 'jekyll', '>= 3.0'

  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'webmock'
end
