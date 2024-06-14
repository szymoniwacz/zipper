# frozen_string_literal: true

module V1
  class Users < Grape::API
    resource :users do
      desc "Register a new user"
      params do
        requires :email, type: String, desc: "Email address"
        requires :password, type: String, desc: "Password"
        requires :password_confirmation, type: String, desc: "Password confirmation"
      end
      post :register do
        user = User.new(params)
        if user.save
          { status: :success, message: "User registered successfully." }
        else
          error!(user.errors.messages, 422)
        end
      end
    end
  end
end
