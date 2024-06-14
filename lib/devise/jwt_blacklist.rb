# frozen_string_literal: true

class JwtBlacklist
  include Devise::JWT::RevocationStrategies::Denylist
end
