class Api::Auth::ApiKeysController < ApplicationController
  before_action :authenticate_with_api_key!

  def index
    render json: ApiKeyBlueprint.render(current_user.api_keys), status: :ok
  end
end
