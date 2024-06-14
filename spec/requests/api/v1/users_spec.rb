# frozen_string_literal: true

require "rails_helper"

describe "V1::Users API", type: :request do
  describe "POST /api/v1/users/register" do
    context "when all request parameters are valid" do
      it "returns success message" do
        post "/api/v1/users/register",
             params: { email: "test@example.com", password: "password123", password_confirmation: "password123" }

        expect(response).to have_http_status(:created)
        expect(json_response["message"]).to eq("User registered successfully.")
      end
    end

    context "when some of request parameters are invalid" do
      it "returns missing password confirmation error" do
        post "/api/v1/users/register", params: { email: "test@example.com", password: "password123" }

        expect(response).to have_http_status(:bad_request)
        expect(json_response["error"]).to eq("Parameter missing or invalid")
        expect(json_response["detail"]).to eq("password_confirmation is missing")
      end
    end
  end

  describe "POST /api/v1/users/login" do
    let!(:user) { create(:user, email: "test@example.com", password: "password123") }

    context "with valid credentials" do
      it "returns authentication token" do
        post "/api/v1/users/login", params: { email: "test@example.com", password: "password123" }

        expect(response).to have_http_status(:ok)
        expect(json_response["token"]).to be_present
      end
    end

    context "with invalid credentials" do
      it "returns unauthorized" do
        post "/api/v1/users/login", params: { email: "invalid@example.com", password: "invalidpassword" }

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  def json_response
    JSON.parse(response.body)
  end
end
