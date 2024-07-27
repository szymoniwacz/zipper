# frozen_string_literal: true

class FileResource < ApplicationRecord
  belongs_to :user
  mount_uploader :file, FileUploader

  validates :file, presence: true
end
