$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "stirling/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "stirling"
  s.version     = Stirling::VERSION
  s.authors     = ["Framgia"]
  s.email       = ["oss@framgia.com"]
  s.homepage    = "https://github.com/framgia/stirling"
  s.summary     = "Rails extension tool"
  s.description = "Rails extension tool"
  s.license     = "MIT"
  s.required_ruby_version = ">= 1.9.3"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
end
