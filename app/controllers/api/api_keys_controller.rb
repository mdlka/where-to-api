class Api::ApiKeysController < ApplicationController
  prepend_before_action :authenticate_with_api_key!, only: [ :index, :destroy ]

  def index
    render json: current_user.api_keys
  end

  def create
    authenticate_with_http_basic do | email, password |
      user = User.find_by(email: email)

      if user&.authenticate(password)
        api_key = user.api_keys.create!(token_digest: SecureRandom.hex)
        render json: api_key, status: :created and return
      end
    end

    head :unauthorized
  end

  def destroy
    api_key = current_user.api_keys.find(params[:id])
    api_key.destroy
  end
end
