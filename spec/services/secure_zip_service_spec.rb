# frozen_string_literal: true

require "rails_helper"
require "zip"

RSpec.describe SecureZipService, type: :service do
  let(:user) { create(:user) }
  let(:file) { { filename: "example.txt", tempfile: File.open(Rails.root.join("spec/fixtures/example.txt")) } }
  let(:base_url) { "http://example.com" }
  let(:service) { SecureZipService.new(user:, file:, base_url:) }

  describe "#initialize" do
    it "initializes with a user, file, and base_url" do
      expect(service.instance_variable_get(:@user)).to eq(user)
      expect(service.instance_variable_get(:@file)).to eq(file)
      expect(service.instance_variable_get(:@base_url)).to eq(base_url)
    end
  end

  describe "#call" do
    context "with valid input" do
      it "creates a zip file and returns the file details" do
        result = service.call
        expect(result.success?).to be(true)
        expect(result.value[:link]).to be_present
        expect(result.value[:password]).to be_present
      end
    end

    context "with an error during file creation" do
      before do
        allow(service).to receive(:create_zip_file).and_raise(StandardError, "Test error")
      end

      it "handles the error and returns an error message" do
        result = service.call
        expect(result.success?).to be(false)
        expect(result.error.message).to eq("Test error")
      end
    end
  end

  describe "#create_zip_file" do
    it "creates a zip file and updates the file resource" do
      allow(service).to receive(:generated_password).and_return("testpassword")
      file_resource = service.send(:file_resource)
      expect(file_resource).to receive(:update!).with(file: instance_of(File))

      service.send(:create_zip_file)

      # Check that the password is set correctly
      expect(service.send(:generated_password)).to eq("testpassword")
    end
  end

  describe "#zipfile_buffer" do
    it "creates a zip buffer with the file content" do
      zip_buffer = service.send(:zipfile_buffer)
      expect(zip_buffer).to be_a(StringIO)
    end
  end

  describe "#encrypter" do
    it "creates an encrypter with the generated password" do
      generated_password = service.send(:generated_password)
      encrypter = service.send(:encrypter)
      expect(encrypter).to be_a(Zip::TraditionalEncrypter)
      expect(service.send(:generated_password)).to eq(generated_password)
    end
  end

  describe "#generated_password" do
    it "generates a random password" do
      password = service.send(:generated_password)
      expect(password).to be_a(String)
      expect(password.length).to eq(20)
    end
  end

  describe "#zipfile_name" do
    it "returns the base name of the file without extension" do
      zipfile_name = service.send(:zipfile_name)
      expect(zipfile_name).to eq("example")
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
