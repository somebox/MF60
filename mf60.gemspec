# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "mf60/version"

Gem::Specification.new do |s|
  s.name        = "mf60"
  s.version     = MF60::VERSION
  s.authors     = ["Jeremy Seitz"]
  s.email       = ["jeremy@somebox.com"]
  s.homepage    = ""
  s.summary     = %q{TODO: Tools for interfacing with the MF60 mobile internet hotspot device.}
  s.description = %q{TODO: A library and command-line tool that talk to the MF60 via the admin web interface. This little box is available from Swisscom (and possibly others). Get statistics, network info, signal strength, and connect, disconnect and reset the device.}

  s.rubyforge_project = "mf60"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:

  # s.add_runtime_dependency "rest-client"
end
