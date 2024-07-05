# frozen_string_literal: true

require "zip"

class SecureZipService
  include ErrorHandler

  def initialize(file_archive_id:)
    @file_archive = FileArchive.find(file_archive_id)
    @user = @file_archive.user
    @file = @file_archive.file_path
  end

  def call
    Result.new
          .map { validate_file }
          .map { create_zip_file }
          .rescue { |error| handle_error(error) }
  end

  private

  attr_accessor :user, :file, :file_archive

  def validate_file
    raise "Invalid file" unless file.present?

    file
  end

  def create_zip_file
    Tempfile.create([zipfile_name, ".zip"], binmode: true) do |tempfile|
      tempfile.write(zipfile_buffer.string)

      file_resource.update!(file: tempfile)

      file_archive.update!(
        zipfile_path: file_resource.file_url,
        status: 'completed'
      )
    end
  end

  def file_resource
    @file_resource ||= user.file_resources.new
  end

  def generated_password
    @generated_password ||= SecureRandom.hex(10)
  end

  def zipfile_name
    @zipfile_name ||= File.basename(file, File.extname(file))
  end

  def zipfile_buffer
    @zipfile_buffer ||= Zip::OutputStream.write_buffer(encrypter:) do |zos|
      zos.put_next_entry(File.basename(file))
      zos.write(File.read(file))
    end
  end

  def encrypter
    @encrypter ||= Zip::TraditionalEncrypter.new(file_archive.password)
  end

  def generate_zip_file_path
    Rails.root.join('uploads', 'zips', "#{SecureRandom.uuid}.zip").to_s
  end

  def handle_error(error)
    file_archive.update!(
      error: error.message,
      status: 'failed'
    )

    super
  end
end
