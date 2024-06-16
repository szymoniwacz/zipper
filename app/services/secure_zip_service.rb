# frozen_string_literal: true

require "zip"

class SecureZipService
  def initialize(user:, file:)
    @user = user
    @file = file
  end

  def call
    Result.new
          .map { create_zip_file }
          .rescue { |error| handle_error(error) }
  end

  private

  attr_accessor :user, :file

  def create_zip_file
    Tempfile.create(["#{zipfile_name}-", ".zip"], binmode: true) do |tempfile|
      tempfile.write(zipfile_buffer.string)

      file_resource = user.file_resources.create!(
        file: tempfile
      )

      { zipfile_path: file_resource.file_url, password: generated_password }
    end
  end

  def zipfile_buffer
    @zipfile_buffer ||= Zip::OutputStream.write_buffer(encrypter:) do |zos|
      zos.put_next_entry(File.basename(file[:filename]))
      zos.write(file[:tempfile].read)
    end
  end

  def encrypter
    @encrypter ||= Zip::TraditionalEncrypter.new(generated_password)
  end

  def generated_password
    @generated_password ||= SecureRandom.hex(10)
  end

  def return_file_details
    user_dir_path = ["uploads", user.id.to_s].join("/")
    { zipfile_path: File.join(user_dir_path, zipfile_name), password: generated_password }
  end

  def zipfile_name
    @zipfile_name ||= File.basename(file[:filename], File.extname(file[:filename]))
  end

  # Log the error, notify someone, or perform any other error handling here
  def handle_error(error)
    Rails.logger.error("An error occurred while archiving file: #{error.message}")
    { error: error.message }
  end
end
