# -*- encoding: utf-8 -*-
# stub: grape-swagger-rails 0.5.0 ruby lib

Gem::Specification.new do |s|
  s.name = "grape-swagger-rails".freeze
  s.version = "0.5.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "bug_tracker_uri" => "https://github.com/ruby-grape/grape-swagger-rails/issues", "changelog_uri" => "https://github.com/ruby-grape/grape-swagger-rails/blob/master/CHANGELOG.md", "rubygems_mfa_required" => "true", "source_code_uri" => "https://github.com/ruby-grape/grape-swagger-rails/tree/v0.5.0" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Alexander Logunov".freeze]
  s.date = "2024-04-06"
  s.description = "Swagger UI as Rails Engine for grape-swagger gem.".freeze
  s.email = ["unlovedru@gmail.com".freeze]
  s.homepage = "https://github.com/ruby-grape/grape-swagger-rails".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.3.3".freeze
  s.summary = "Swagger UI as Rails Engine for grape-swagger gem.".freeze

  s.installed_by_version = "3.3.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<railties>.freeze, [">= 6.0.6.1"])
  else
    s.add_dependency(%q<railties>.freeze, [">= 6.0.6.1"])
  end
end
