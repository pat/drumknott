# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = "drumknott"
  spec.version       = "0.4.0"
  spec.authors       = ["Pat Allan"]
  spec.email         = ["pat@freelancing-gods.com"]

  spec.summary       = "Jekyll content uploader for Drumknott's search service."
  spec.description   = "Takes each of your compiled Jekyll pages and uploads " \
    "them to Drumknott."
  spec.homepage      = "https://github.com/pat/drumknott"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |file|
    file.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |file| File.basename(file) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 3.1"

  spec.add_runtime_dependency "faraday"
  spec.add_runtime_dependency "jekyll", ">= 3.0"
  spec.add_runtime_dependency "json"

  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rubocop"
  spec.add_development_dependency "webmock"
end
