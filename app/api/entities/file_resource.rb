# frozen_string_literal: true

module Entities
  class FileResource < Grape::Entity
    expose :id, documentation: { type: "Integer", desc: "File ID" }
    expose :file_url, documentation: { type: "String", desc: "URL to uploaded file" } do |resource, options|
      "#{options[:domain]}#{resource.file_url}"
    end
    expose :created_at, documentation: { type: "DateTime", desc: "Creation timestamp" }
    expose :user_id
  end
end
