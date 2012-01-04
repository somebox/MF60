# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "mf60/version"

Gem::Specification.new do |s|
  s.name        = "mf60"
  s.version     = MF60::VERSION
  s.authors     = ["Jeremy Seitz"]
  s.email       = ["jeremy@somebox.com"]
  s.homepage    = ""
  s.summary     = %q{Ruby library and command-line tool for interfacing with the MF60 mobile internet hotspot device.}
  s.description = %q{A library and command-line tool that talk to the MF60 via the admin web interface. This little battery-powered box is available from Swisscom in Switzerland (as well as mobile operators in other countries). With this gem you can get statistics, network info, signal strength, connect, disconnect and reset the device.}

  s.rubyforge_project = "mf60"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:

  s.add_runtime_dependency "httparty"
  s.add_runtime_dependency "thor"  
  
  s.add_development_dependency "guard"
  s.add_development_dependency "guard-test"  
end
