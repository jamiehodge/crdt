$:.push File.expand_path("lib", __dir__)
require "crdt/version"

Gem::Specification.new do |gem|
  gem.name        = "crdt"
  gem.version     = Crdt::VERSION
  gem.licenses    = ["MIT"]
  gem.platform    = Gem::Platform::RUBY
  gem.authors     = ["Jamie Hodge"]
  gem.email       = ["jamiehodge@me.com"]
  gem.homepage    = ""
  gem.summary     = ""
  gem.description = gem.summary

  gem.files         = Dir.glob("lib/**/*")
  gem.test_files    = Dir.glob("test/**/*")
  gem.executables   = Dir.glob("bin/*").map { |f| File.basename(f) }
  gem.require_paths = ["lib"]

  gem.add_development_dependency "minitest"
  gem.add_development_dependency "rake"
end
