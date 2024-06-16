# frozen_string_literal: true

class FileUploader < CarrierWave::Uploader::Base
  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def cache_dir
    Rails.root.join("tmp", "uploads", "test")
  end

  def extension_white_list
    %w[zip] # Allow only zip files for upload
  end
end