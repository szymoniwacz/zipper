# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable, :jwt_authenticatable,
         jwt_revocation_strategy: JwtBlacklist

  has_many :file_resources

  validates :email, presence: true, uniqueness: true

  before_save :ensure_authentication_token

  def ensure_authentication_token
    return unless authentication_token.blank?

    self.authentication_token = generate_authentication_token
  end

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.exists?(authentication_token: token)
    end
  end

  def jwt_payload(expiration = 1.day.from_now)
    { email:, authentication_token:, exp: expiration.to_i }
  end
end
