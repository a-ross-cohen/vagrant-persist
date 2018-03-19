
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "vagrant/persist/version"

Gem::Specification.new do |spec|
  spec.name          = "vagrant-persist"
  spec.version       = Vagrant::Persist::VERSION
  spec.authors       = ["A. Ross Cohen"]
  spec.email         = ["a.ross.cohen@gmail.com"]

  spec.summary       = %q{Persistent storage plugin for Vagrant}
  spec.description   = %q{Persistent storage managemennt and mounting plugin to allow for additional virtual disks to be mounted and saved across sessions.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
