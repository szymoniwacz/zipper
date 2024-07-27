# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  describe "validations" do
    it "validates presence of email" do
      user = User.new(email: nil, password: "password")
      expect(user).to_not be_valid
      expect(user.errors[:email]).to include("can't be blank")
    end

    it "validates uniqueness of email (case insensitive)" do
      User.create(email: "test@example.com", password: "password")
      user = User.new(email: "test@example.com", password: "password")
      expect(user).to_not be_valid
      expect(user.errors[:email]).to include("has already been taken")
    end

    it "validates presence of password" do
      user = User.new(email: "test@example.com", password: nil)
      expect(user).to_not be_valid
      expect(user.errors[:password]).to include("can't be blank")
    end

    it "validates length of password" do
      user = User.new(email: "test@example.com", password: "short")
      expect(user).to_not be_valid
      expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")

      user.password = "a" * 129
      expect(user).to_not be_valid
      expect(user.errors[:password]).to include("is too long (maximum is 128 characters)")
    end
  end

  describe "devise modules" do
    it "should include :database_authenticatable module" do
      expect(User.devise_modules).to include(:database_authenticatable)
    end

    it "should include :registerable module" do
      expect(User.devise_modules).to include(:registerable)
    end

    it "should include :recoverable module" do
      expect(User.devise_modules).to include(:recoverable)
    end

    it "should include :validatable module" do
      expect(User.devise_modules).to include(:validatable)
    end
  end
end
