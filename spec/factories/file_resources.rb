# frozen_string_literal: true

FactoryBot.define do
  factory :file_resource do
    association :user
    file { Rack::Test::UploadedFile.new(Rails.root.join("spec/fixtures/example.txt"), "text/plain") }
  end
end
