# frozen_string_literal: true

require 'rails_helper'
require 'zip'

RSpec.describe SecureZipService, type: :service do
  let(:user) { create(:user) }
  let(:file_path) { Rails.root.join('tmp', 'testfile.txt').to_s }
  let(:file_archive) { create(:file_archive, user: user, file_path: file_path) }
  let(:service) { described_class.new(file_archive_id: file_archive.id) }

  before do
    # Create a test file
    File.open(file_path, 'w') { |f| f.write('This is a test file') }
  end

  after do
    # Clean up the test file
    File.delete(file_path) if File.exist?(file_path)
  end

  describe '#call' do
    it 'calls create_zip_file and updates the file archive' do
      expect(service).to receive(:create_zip_file).and_call_original
      service.call
      file_archive.reload
      expect(file_archive.status).to eq('completed')
      expect(file_archive.zipfile_path).not_to be_nil
    end
  end

  describe '#create_zip_file' do
    it 'creates a zip file and updates the file archive' do
      service.send(:create_zip_file)
      file_archive.reload
      expect(file_archive.status).to eq('completed')
      expect(file_archive.zipfile_path).not_to be_nil

      # Clean up the created zip file
      File.delete(file_archive.zipfile_path) if File.exist?(file_archive.zipfile_path)
    end
  end

  describe '#zipfile_name' do
    it 'returns the correct zipfile name' do
      expect(service.send(:zipfile_name)).to eq('testfile')
    end
  end

  describe "#zipfile_buffer" do
    it "creates a zip buffer with the file content" do
      zip_buffer = service.send(:zipfile_buffer)
      expect(zip_buffer).to be_a(StringIO)
    end
  end

  describe '#encrypter' do
    it 'returns a Zip::TraditionalEncrypter with the file archive password' do
      encrypter = service.send(:encrypter)
      expect(encrypter).to be_a(Zip::TraditionalEncrypter)
      expect(encrypter.instance_variable_get(:@password)).to eq(file_archive.password)
    end
  end

  describe '#generate_zip_file_path' do
    it 'generates a valid zip file path in the uploads directory' do
      path = service.send(:generate_zip_file_path)
      expect(path).to start_with(Rails.root.join('uploads', 'zips').to_s)
      expect(path).to end_with('.zip')
    end
  end

  describe "#zipfile_name" do
    it "returns the base name of the file without extension" do
      zipfile_name = service.send(:zipfile_name)
      expect(zipfile_name).to eq("testfile")
    end
  end

  describe "#handle_error" do
    it "logs the error and returns an error result" do
      allow(Rails.logger).to receive(:error)
      error_message = "Test error message"
      result = service.send(:handle_error, StandardError.new(error_message))

      expect(Rails.logger).to have_received(:error).with("An error occurred: Test error message")
      expect(result.error).to eq("Test error message")
    end
  end
end
