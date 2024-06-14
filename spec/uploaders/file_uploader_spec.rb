# frozen_string_literal: true

require "rails_helper"
require "carrierwave/test/matchers"

describe FileUploader do
  include CarrierWave::Test::Matchers

  let(:user) { create(:user) }
  let(:uploader) { described_class.new(user, :file) }

  before do
    described_class.enable_processing = true
    FileUploader.storage = :file
  end

  after do
    described_class.enable_processing = false
    uploader.remove!
  end

  context "file storage" do
    it "stores files in the correct directory" do
      expect(uploader.store_dir).to eq("uploads/user/file/#{user.id}")
    end
  end

  context "file upload" do
    let(:file_path) { Rails.root.join("spec", "fixtures", "example.txt") }

    before do
      File.open(file_path) { |f| uploader.store!(f) }
    end

    it "uploads the file" do
      expect(uploader.file).to be_present
    end

    it "has the correct extension" do
      expect(uploader.file.extension).to eq("txt")
    end

    it "can be downloaded" do
      expect(uploader.url).to include("example.txt")
    end

    it "is stored in the expected directory" do
      expect(uploader.current_path).to start_with("#{Rails.root}/public/uploads/user/file/#{user.id}/")
    end
  end
end
