# frozen_string_literal: true

require "rails_helper"

RSpec.describe UserAuthenticationService do
  describe "#call" do
    let(:email) { "test@example.com" }
    let(:password) { "password123" }
    let(:service) { described_class.new(email, password) }

    context "when the user exists and the password is correct" do
      let!(:user) { create(:user, email:, password:) }

      it "returns a successful result with a token" do
        result = service.call

        expect(result).to be_success
        expect(result.error).to be_nil
        expect(result.value).not_to be_nil
        expect do
          JWT.decode(result.value, Rails.application.secrets.secret_key_base, true, algorithm: "HS256")
        end.not_to raise_error
      end
    end

    context "when the user does not exist" do
      it "returns an error result" do
        result = service.call

        expect(result).not_to be_success
        expect(result.error.message).to eq("Unauthorized")
        expect(result.value).to be_nil
      end
    end

    context "when the password is incorrect" do
      let!(:user) { create(:user, email:, password: "wrongpassword") }

      it "returns an error result" do
        result = service.call

        expect(result).not_to be_success
        expect(result.error.message).to eq("Unauthorized")
        expect(result.value).to be_nil
      end
    end

    context "when an error occurs during token generation" do
      let!(:user) { create(:user, email:, password:) }

      before do
        allow(JWT).to receive(:encode).and_raise(StandardError, "Token generation error")
        allow(Rails.logger).to receive(:error) # Mocking the logger
      end

      it "logs the error and returns a failure result" do
        result = service.call

        expect(Rails.logger).to have_received(:error).with("An error occurred: Token generation error")
        expect(result).not_to be_success
        expect(result.error.message).to eq("Token generation error")
        expect(result.value).to be_nil
      end
    end
  end
end
