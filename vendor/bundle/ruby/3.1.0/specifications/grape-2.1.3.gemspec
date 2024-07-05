# -*- encoding: utf-8 -*-
# stub: grape 2.1.3 ruby lib

Gem::Specification.new do |s|
  s.name = "grape".freeze
  s.version = "2.1.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "bug_tracker_uri" => "https://github.com/ruby-grape/grape/issues", "changelog_uri" => "https://github.com/ruby-grape/grape/blob/v2.1.3/CHANGELOG.md", "documentation_uri" => "https://www.rubydoc.info/gems/grape/2.1.3", "source_code_uri" => "https://github.com/ruby-grape/grape/tree/v2.1.3" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Michael Bleigh".freeze]
  s.date = "2024-07-13"
  s.description = "A Ruby framework for rapid API development with great conventions.".freeze
  s.email = ["michael@intridea.com".freeze]
  s.homepage = "https://github.com/ruby-grape/grape".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.7.0".freeze)
  s.rubygems_version = "3.3.3".freeze
  s.summary = "A simple Ruby framework for building REST-like APIs.".freeze

  s.installed_by_version = "3.3.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<activesupport>.freeze, [">= 6"])
    s.add_runtime_dependency(%q<dry-types>.freeze, [">= 1.1"])
    s.add_runtime_dependency(%q<mustermann-grape>.freeze, ["~> 1.1.0"])
    s.add_runtime_dependency(%q<rack>.freeze, [">= 2"])
    s.add_runtime_dependency(%q<zeitwerk>.freeze, [">= 0"])
  else
    s.add_dependency(%q<activesupport>.freeze, [">= 6"])
    s.add_dependency(%q<dry-types>.freeze, [">= 1.1"])
    s.add_dependency(%q<mustermann-grape>.freeze, ["~> 1.1.0"])
    s.add_dependency(%q<rack>.freeze, [">= 2"])
    s.add_dependency(%q<zeitwerk>.freeze, [">= 0"])
  end
end