# frozen_string_literal: true

class Base < Grape::API
  prefix "api"
  format :json

  mount V1::Base
end
