# frozen_string_literal: true

module V1
  class Base < Grape::API
    version "v1", using: :path

    helpers do
      def authenticate_user!
        error!("Unauthorized", 401) unless current_user
      end

      def current_user
        @current_user ||= warden.authenticate(scope: :user)
      end

      def warden
        env["warden"]
      end
    end

    mount V1::Users
  end
end
