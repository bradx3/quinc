# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "quinc/version"

Gem::Specification.new do |s|
  s.name        = "quinc"
  s.version     = Quinc::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Brad Wilson"]
  s.email       = ["brad@lucky-dip.net"]
  s.homepage    = ""
  s.summary     = %q{Quickly synchronise folders across one or more destinations}
  s.description = %q{}

  s.rubyforge_project = "quinc"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
