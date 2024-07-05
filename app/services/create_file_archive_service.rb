# frozen_string_literal: true

class CreateFileArchiveService
  include ErrorHandler

  def initialize(file:, user:)
    @file = file
    @user = user
  end

  def call
    Result.new
          .map { save_file }
          .map { create_file_archive }
          .rescue { |error| handle_error(error) }
  end

  private

  attr_reader :file, :user

  def save_file
    FileUtils.mkdir_p(File.dirname(file_path))
    File.open(file_path, 'wb') do |f|
      f.write(file[:tempfile].read)
    end
  rescue StandardError => e
    raise "Failed to save file: #{e.message}"
  end

  def file_path
    @file_path ||= Rails.root.join('tmp', SecureRandom.uuid, file[:filename])
  end

  def create_file_archive
    FileArchive.create!(
      user: user,
      file_path: file_path,
      status: 'processing'
    )
  rescue ActiveRecord::RecordInvalid => e
    raise "Failed to create file archive: #{e.message}"
  end
end
