# frozen_string_literal: true

require "rails_helper"

RSpec.describe Result do
  describe "#map" do
    context "when there is no error" do
      it "returns a new Result with mapped value" do
        result = Result.new(5)
        mapped_result = result.map { |x| x * 2 }

        expect(mapped_result.value).to eq(10)
        expect(mapped_result.error).to be_nil
      end
    end

    context "when there is an error during mapping" do
      it "returns a new Result with error" do
        result = Result.new(5)
        mapped_result = result.map { |_x| raise "Some error" }

        expect(mapped_result.value).to be_nil
        expect(mapped_result.error).to be_a(StandardError)
      end
    end

    context "when there is already an error" do
      it "returns self without calling the block" do
        error_result = Result.new(nil, "Previous error")
        mapped_result = error_result.map { |x| x * 2 }

        expect(mapped_result).to eq(error_result)
      end
    end
  end

  describe "#success?" do
    it "returns true if there is no error" do
      result = Result.new(5)
      expect(result.success?).to be(true)
    end

    it "returns false if there is an error" do
      result = Result.new(nil, "Some error")
      expect(result.success?).to be(false)
    end
  end

  describe "#failure?" do
    it "returns false if there is no error" do
      result = Result.new(5)
      expect(result.failure?).to be(false)
    end

    it "returns true if there is an error" do
      result = Result.new(nil, "Some error")
      expect(result.failure?).to be(true)
    end
  end

  describe "#rescue" do
    context "when there is no error" do
      it "returns self without modifying it" do
        result = Result.new(5)
        rescued_result = result.rescue { |e| puts "Rescued: #{e}" }

        expect(rescued_result).to eq(result)
        expect(rescued_result.error).to be_nil
      end
    end

    context "when there is already an error" do
      it "returns a new Result with rescued error" do
        error_result = Result.new(nil, "Previous error")
        rescued_result = error_result.rescue(&:message)

        expect(rescued_result.value).to be_nil
        expect(rescued_result.error).to eq("Previous error")
      end
    end
  end
end
