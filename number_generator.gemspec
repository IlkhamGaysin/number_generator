# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'number_generator'

Gem::Specification.new do |spec|
  spec.name          = "number_generator"
  spec.version       = NumberGenerator::VERSION
  spec.authors       = ["IlkhamGaysin"]
  spec.email         = ["ilkham.gaysin@flatstack.com"]

  spec.summary       = %q{Simple test task for Stack Builders}
  spec.homepage      = "https://github.com/IlkhamGaysin/number_generator"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "byebug"
  spec.add_development_dependency "timecop"
end
