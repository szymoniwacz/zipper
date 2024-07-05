# spec/services/error_handler_spec.rb

require "rails_helper"

RSpec.describe ErrorHandler do
  let(:dummy_class) { Class.new { include ErrorHandler } }
  let(:dummy_instance) { dummy_class.new }

  describe "#handle_error" do
    let(:error_message) { "Something went wrong" }
    let(:error) { StandardError.new(error_message) }
    let(:result) { dummy_instance.handle_error(error) }

    it "logs the error message" do
      expect(Rails.logger).to receive(:error).with("An error occurred: #{error.message}")
      result
    end

    it "returns a failure result with the error message" do
      expect(result.error).to eq(error_message)
    end
  end
end
