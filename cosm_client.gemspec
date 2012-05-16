# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "cosm_client/version"

Gem::Specification.new do |s|
  s.name        = "cosm_client"
  s.version     = CosmClient::VERSION
  s.authors     = ["Sam Mulube"]
  s.email       = ["sam@pachube.com"]
  s.homepage    = ""
  s.summary     = %q{Simple Ruby client for accessing the Cosm API via OAuth.}
  s.description = %q{Simple Ruby client for accessing the Cosm API via OAuth. Does not have any object model representing the API, data is just returned as JSON strings.}

  s.rubyforge_project = "cosm_client"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec"
  s.add_development_dependency "rake"
  s.add_development_dependency "webmock"
end
