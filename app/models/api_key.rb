class ApiKey < ApplicationRecord
  HMAC_SECRET_KEY = ENV.fetch("API_KEY_HMAC_SECRET_KEY")
  DIGEST = "SHA256"

  belongs_to :user

  before_create :generate_token_hmac_digest

  attr_accessor :token

  def self.authenticate_by_token!(token)
    digest = OpenSSL::HMAC.hexdigest(DIGEST, HMAC_SECRET_KEY, token)
    find_by!(token_digest: digest)
  end

  def self.authenticate_by_token(token)
    authenticate_by_token!(token)
  rescue ActiveRecord::RecordNotFound
    nil
  end

  private

  def generate_token_hmac_digest
    raise ActiveRecord::RecordInvalid, "token is required" unless token.present?

    digest = OpenSSL::HMAC.hexdigest(DIGEST, HMAC_SECRET_KEY, token)
    self.token_digest = digest
  end
end
