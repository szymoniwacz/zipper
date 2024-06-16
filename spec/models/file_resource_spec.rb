# frozen_string_literal: true

require "rails_helper"

RSpec.describe FileResource, type: :model do
  let(:user) { create(:user) }

  describe "associations" do
    it "belongs to user" do
      file_resource = described_class.reflect_on_association(:user)
      expect(file_resource.macro).to eq(:belongs_to)
    end
  end

  describe "validations" do
    it "validates presence of file" do
      file_resource = build(:file_resource, user:, file: nil)
      file_resource.valid?
      expect(file_resource.errors[:file]).to include("can't be blank")
    end

    it "validates presence of user" do
      file_resource = build(:file_resource, user: nil, file: nil)
      file_resource.valid?
      expect(file_resource.errors[:user]).to include("must exist")
    end
  end
end
