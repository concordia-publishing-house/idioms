# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "idioms/version"

Gem::Specification.new do |spec|
  spec.name          = "idioms"
  spec.version       = Idioms::VERSION
  spec.authors       = ["EP"]
  spec.email         = ["epdeveloper@cph.org"]
  spec.summary       = %q{EP's extensions to the Ruby language}
  spec.description   = %q{EP's extensions to the Ruby language}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport", ">= 3.2.0"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake", "~> 12.3"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "minitest-reporters"
  spec.add_development_dependency "minitest-reporters-turn_reporter"
  spec.add_development_dependency "shoulda-context"
  spec.add_development_dependency "timecop"
end
