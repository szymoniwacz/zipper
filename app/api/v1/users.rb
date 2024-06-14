# frozen_string_literal: true

module V1
  class Users < Grape::API
    resource :users do
      desc "Register a new user", {
        consumes: ["application/json"],
        produces: ["application/json"]
      }
      params do
        requires :email, type: String, desc: "Email address"
        requires :password, type: String, desc: "Password"
        requires :password_confirmation, type: String, desc: "Password confirmation"
      end
      post :register do
        user = User.new(params)
        if user.save
          status 201
          { message: "User registered successfully." }
        else
          error!(user.errors.messages, 422)
        end
      end

      desc "Login", {
        consumes: ["application/json"],
        produces: ["application/json"]
      }
      params do
        requires :email, type: String, desc: "Email address"
        requires :password, type: String, desc: "Password"
      end
      post :login do
        user = User.find_for_authentication(email: params[:email])
        if user&.valid_password?(params[:password])
          user.ensure_authentication_token
          user.save!
          token = JWT.encode(user.jwt_payload, Rails.application.secrets.secret_key_base, "HS256")
          status 200

          { token: }
        else
          error!("Unauthorized", 401)
        end
      end
    end
  end
end
