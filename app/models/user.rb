class User < ApplicationRecord
  has_secure_password

  has_many :api_keys

  validates :password, allow_nil: true, length: { minimum: 6 }
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  normalizes :email, with: ->(e) { e.strip.downcase }
end
