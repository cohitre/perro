# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{perro}
  s.version = "0.9.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["carlos"]
  s.date = %q{2008-11-22}
  s.description = %q{Perro is a light server built on top of mongrel that helps at least  one developer be happy. If it had been designed as production server  it would have a cooler name. Like "Dinosaur" or "Freckle".  The Internet is a global system of interconnected computer networks.  Developer creates files that are served through this global system.  Developer may be tempted to develop such files by creating a folder,  moving the files to such folder, double clicking them and watching  what happens on the browser whose address bar reads  "file:///Users/cohitre/development/my-project/index.html".  Perro helps developer be happy by helping overcome temptation.}
  s.email = ["carlosrr@gmail.com"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.txt"]
  s.files = ["History.txt", "Manifest.txt", "README.txt", "Rakefile", "lib/perro.rb", "lib/perro/route.rb", "test/test_perro.rb", "test/sample.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://code.cohitre.com}
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{perro}
  s.rubygems_version = %q{1.3.0}
  s.summary = %q{A quick and dirty solution for serving files easily.}
  s.test_files = ["test/test_perro.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<mongrel>, [">= 1.1.4"])
      s.add_runtime_dependency(%q<haml>, [">= 2.0.3"])
      s.add_development_dependency(%q<hoe>, [">= 1.8.0"])
    else
      s.add_dependency(%q<mongrel>, [">= 1.1.4"])
      s.add_dependency(%q<haml>, [">= 2.0.3"])
      s.add_dependency(%q<hoe>, [">= 1.8.0"])
    end
  else
    s.add_dependency(%q<mongrel>, [">= 1.1.4"])
    s.add_dependency(%q<haml>, [">= 2.0.3"])
    s.add_dependency(%q<hoe>, [">= 1.8.0"])
  end
end
