# frozen_string_literal: true

class UserAuthenticationService
  include ErrorHandler

  def initialize(email, password)
    @user = User.find_for_authentication(email:)
    @password = password
  end

  def call
    # binding.pry
    Result.new
          .map { validate_user }
          .map { generate_token }
          .rescue { |error| handle_error(error) }
  end

  private

  attr_accessor :user, :password

  def validate_user
    raise StandardError, "Unauthorized" unless user&.valid_password?(password)

    user.ensure_authentication_token
    user.save!
    user
  end

  def generate_token
    JWT.encode(user.jwt_payload, Rails.application.secrets.secret_key_base, "HS256")
  end
end
