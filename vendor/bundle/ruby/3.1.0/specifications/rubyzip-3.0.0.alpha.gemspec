# -*- encoding: utf-8 -*-
# stub: rubyzip 3.0.0.alpha ruby lib

Gem::Specification.new do |s|
  s.name = "rubyzip".freeze
  s.version = "3.0.0.alpha"

  s.required_rubygems_version = Gem::Requirement.new("> 1.3.1".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "bug_tracker_uri" => "https://github.com/rubyzip/rubyzip/issues", "changelog_uri" => "https://github.com/rubyzip/rubyzip/blob/v3.0.0.alpha/Changelog.md", "documentation_uri" => "https://www.rubydoc.info/gems/rubyzip/3.0.0.alpha", "source_code_uri" => "https://github.com/rubyzip/rubyzip/tree/v3.0.0.alpha", "wiki_uri" => "https://github.com/rubyzip/rubyzip/wiki" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Robert Haines".freeze, "John Lees-Miller".freeze, "Alexander Simonov".freeze]
  s.date = "2023-04-16"
  s.email = ["hainesr@gmail.com".freeze, "jdleesmiller@gmail.com".freeze, "alex@simonov.me".freeze]
  s.homepage = "http://github.com/rubyzip/rubyzip".freeze
  s.licenses = ["BSD-2-Clause".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.5".freeze)
  s.rubygems_version = "3.3.3".freeze
  s.summary = "rubyzip is a ruby module for reading and writing zip files".freeze

  s.installed_by_version = "3.3.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<minitest>.freeze, ["~> 5.4"])
    s.add_development_dependency(%q<rake>.freeze, ["~> 12.3.3"])
    s.add_development_dependency(%q<rdoc>.freeze, ["~> 6.4.0"])
    s.add_development_dependency(%q<rubocop>.freeze, ["~> 1.12.0"])
    s.add_development_dependency(%q<rubocop-performance>.freeze, ["~> 1.10.0"])
    s.add_development_dependency(%q<rubocop-rake>.freeze, ["~> 0.5.0"])
    s.add_development_dependency(%q<simplecov>.freeze, ["~> 0.18.0"])
    s.add_development_dependency(%q<simplecov-lcov>.freeze, ["~> 0.8"])
  else
    s.add_dependency(%q<minitest>.freeze, ["~> 5.4"])
    s.add_dependency(%q<rake>.freeze, ["~> 12.3.3"])
    s.add_dependency(%q<rdoc>.freeze, ["~> 6.4.0"])
    s.add_dependency(%q<rubocop>.freeze, ["~> 1.12.0"])
    s.add_dependency(%q<rubocop-performance>.freeze, ["~> 1.10.0"])
    s.add_dependency(%q<rubocop-rake>.freeze, ["~> 0.5.0"])
    s.add_dependency(%q<simplecov>.freeze, ["~> 0.18.0"])
    s.add_dependency(%q<simplecov-lcov>.freeze, ["~> 0.8"])
  end
end
