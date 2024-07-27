# frozen_string_literal: true

class Base < Grape::API
  prefix "api"
  format :json

  rescue_from Grape::Exceptions::ValidationErrors do |e|
    error!({ error: "Parameter missing or invalid", detail: e.message }, 400)
  end

  mount V1::Base
end
