# frozen_string_literal: true

require "devise/strategies/authenticatable"

module Strategies
  class Jwt < Devise::Strategies::Authenticatable
    def valid?
      token.present?
    end

    def authenticate!
      return nil unless valid_payload?

      success!(find_or_create_user)
    end

    private

    def token
      request.headers["Authorization"]&.split&.last
    end

    def valid_payload?
      decode_token && !token_expired?
    end

    def token_expired?
      payload["exp"] && Time.at(payload["exp"]) < Time.now
    end

    def find_or_create_user
      User.find_by(email: payload["email"]) || User.create!(email: payload["email"],
                                                            authentication_token: payload["authentication_token"])
    end

    def payload
      @payload ||= decode_token
    end

    def decode_token
      JWT.decode(token, Rails.application.secrets.secret_key_base, true, algorithm: "HS256").first
    rescue JWT::DecodeError
      nil
    end
  end
end

Warden::Strategies.add(:jwt, Strategies::Jwt)
