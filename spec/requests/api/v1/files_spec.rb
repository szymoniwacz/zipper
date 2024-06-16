# frozen_string_literal: true

require "rails_helper"

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
      let(:link) { "link" }
      let(:password) { "password" }
      let(:success_response) { Result.new(value: { link:, password: }) }

      before { allow_any_instance_of(SecureZipService).to receive(:call).and_return(success_response) }

      it "uploads a file and returns a download link and password" do
        post("/api/v1/files", params: { file: }, headers:)

        expect(response).to have_http_status(:created)

        response_body = JSON.parse(response.body)

        expect(response_body["link"]).to include(link)
        expect(response_body["password"]).to eq(password)
      end
    end

    context "when file upload causes error" do
      let(:error) { RuntimeError.new("Error message") }
      let(:error_response) { Result.new(error:) }

      before { allow_any_instance_of(SecureZipService).to receive(:call).and_return(error_response) }

      it "uploads a file and returns a download link and password" do
        post("/api/v1/files", params: { file: }, headers:)
        expect(response).to have_http_status(422)

        response_body = JSON.parse(response.body)

        expect(response_body["error"]).to include(error.message)
      end
    end
  end
end
