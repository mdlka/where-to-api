module ApiKeyAuthentication
  extend ActiveSupport::Concern

  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include ActionController::HttpAuthentication::Token::ControllerMethods

  # @return [ApiKey, nil]
  attr_reader :current_api_key

  # @return [User, nil]
  attr_reader :current_user

  def authenticate_with_api_key!
    @current_user = authenticate_or_request_with_http_token(&method(:authenticate))
  end

  def authenticate_with_api_key
    @current_user = authenticate_with_http_token(&method(:authenticate))
  end

  private

  def authenticate(http_token, options)
    @current_api_key = ApiKey.authenticate_by_token(http_token)
    current_api_key&.user
  end
end
