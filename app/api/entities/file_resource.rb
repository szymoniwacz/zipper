# frozen_string_literal: true

module Entities
  class FileResource < Grape::Entity
    expose :id
    expose :file_url do |resource, options|
      "#{options[:domain]}#{resource.file_url}"
    end
    expose :created_at
  end
end
