class Api::Auth::AuthController < ApplicationController
  before_action :authenticate_with_api_key!, only: [ :logout ]

  def signup
    user = User.new(user_params)

    if user.save
      render json: user, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_content
    end
  end

  def login
    if (user = User.authenticate_by(user_params))
      api_key = user.api_keys.create!(token: SecureRandom.hex)
      response.headers["Authorization"] = "Bearer #{api_key.token}"
      render json: user, status: :ok
    else
      render json: { error: "Invalid email or password" }, status: :unauthorized
    end
  end

  def logout
    current_api_key&.destroy
    head :ok
  end

  private

  def user_params
    params.expect(user: [ :email, :password ])
  end
end
