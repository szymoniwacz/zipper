# frozen_string_literal: true

require "zip"

class SecureZipService
  include ErrorHandler

  def initialize(user:, file:, base_url:)
    @user = user
    @file = file
    @base_url = base_url
  end

  def call
    Result.new
          .map { validate_file }
          .map { create_zip_file }
          .map { return_file_details }
          .rescue { |error| handle_error(error) }
  end

  private

  attr_reader :user, :file, :base_url

  def validate_file
    raise "Invalid file" unless file.present?

    file
  end

  def create_zip_file
    Tempfile.create(["#{zipfile_name}-", ".zip"], binmode: true) do |tempfile|
      tempfile.write(zipfile_buffer.string)
      file_resource.update!(file: tempfile)
    end
  end

  def file_resource
    @file_resource ||= user.file_resources.new
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
    {
      link: File.join(base_url, file_resource.file_url),
      password: generated_password
    }
  end

  def zipfile_name
    @zipfile_name ||= File.basename(file[:filename], File.extname(file[:filename]))
  end
end
