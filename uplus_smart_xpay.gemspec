# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'uplus_smart_xpay/version'

Gem::Specification.new do |spec|
  spec.name          = "uplus_smart_xpay"
  spec.version       = UplusSmartXpay::VERSION
  spec.authors       = ["KunHa"]
  spec.email         = ["potato9@gmail.com"]
  spec.description   = %q{uplus xpay ruby gem}
  spec.summary       = %q{LG Uplus의 xpay 결제모듈 ruby gem 입니다.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "httparty"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
