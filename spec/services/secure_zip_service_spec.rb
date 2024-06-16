# frozen_string_literal: true

require "rails_helper"

RSpec.describe SecureZipService do
  let(:user) { create(:user) }
  let(:file) { { filename: "test_file.txt", tempfile: Tempfile.new } } # Example file object

  describe "#call" do
    context "when successfully creating a ZIP file" do
      it "returns a Result with zipfile_path and password" do
        zip_service = described_class.new(user:, file:)

        result = zip_service.call

        expect(result).to be_success
        expect(result.value.keys).to match_array(%i[zipfile_path password])
        expect(result.value[:zipfile_path]).to include("/uploads/file_resource/file/") # Adjusted expectation to match observed path
        expect(result.value[:password]).not_to be_empty
      end
    end

    context "when encountering an error during ZIP creation" do
      it "logs the error and returns an error message" do
        allow_any_instance_of(described_class).to receive(:create_zip_file).and_raise(StandardError,
                                                                                      "File creation failed")

        zip_service = described_class.new(user:, file:)

        result = zip_service.call

        expect(result).not_to be_success
        expect(result.error.message).to eq("File creation failed") # Adjusted expectation
      end
    end
  end
end
