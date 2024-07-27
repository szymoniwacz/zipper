# -*- encoding: utf-8 -*-
# stub: grape-swagger-entity 0.5.4 ruby lib

Gem::Specification.new do |s|
  s.name = "grape-swagger-entity".freeze
  s.version = "0.5.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "rubygems_mfa_required" => "true" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Kirill Zaitsev".freeze]
  s.bindir = "exe".freeze
  s.date = "2024-04-19"
  s.email = ["kirik910@gmail.com".freeze]
  s.homepage = "https://github.com/ruby-grape/grape-swagger-entity".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 3.0".freeze)
  s.rubygems_version = "3.3.3".freeze
  s.summary = "Grape swagger adapter to support grape-entity object parsing".freeze

  s.installed_by_version = "3.3.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<grape-entity>.freeze, ["~> 1"])
    s.add_runtime_dependency(%q<grape-swagger>.freeze, ["~> 2"])
  else
    s.add_dependency(%q<grape-entity>.freeze, ["~> 1"])
    s.add_dependency(%q<grape-swagger>.freeze, ["~> 2"])
  end
end
