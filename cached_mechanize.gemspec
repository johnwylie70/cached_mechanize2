# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "cached_mechanize"
  spec.version       = "0.0.2"
  spec.authors       = ["wukerplank"]
  spec.email         = ["wukerplank@edthofer.at"]
  spec.summary       = %q{A small wrapper around Mechanize to enable caching for GET requests.}
  spec.homepage      = "https://github.com/wukerplank/cached_mechanize"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "mechanize", "~> 2.7"

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
