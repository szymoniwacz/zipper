# frozen_string_literal: true

require "rails_helper"
require "sidekiq/testing"

RSpec.describe "V1::Files API", type: :request do
  let(:user) { create(:user) }
  let(:token) do
    JWT.encode(user.jwt_payload, Rails.application.secrets.secret_key_base, "HS256")
  end
  let(:headers) { { "Authorization" => "Bearer #{token}" } }

  before do
    allow_any_instance_of(FileUploader).to receive(:store_dir).and_return("/tmp/uploads/test")
  end

  describe "GET /api/v1/files" do
    it "returns a list of files for the logged-in user" do
      create_list(:file_resource, 3, user:)

      get("/api/v1/files", headers:)

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(3)
    end
  end

  describe "POST /api/v1/files" do
    let(:file) { fixture_file_upload(Rails.root.join("spec", "fixtures", "example.txt"), "text/plain") }

    context "when file uploaded successfully" do
      it "uploads a file and enqueues SecureZipServiceWorker" do
        expect {
          post("/api/v1/files", params: { file: file }, headers: headers)
        }.to change(SecureZipServiceWorker.jobs, :size).by(1)

        expect(response).to have_http_status(:created)

        response_body = JSON.parse(response.body)

        expect(response_body["status"]).to eq('processing')
        expect(response_body["link"]).to be_nil
        expect(response_body["password"]).to be_nil
        expect(response_body["archive_url"]).to be_present
      end
    end
  end
end
