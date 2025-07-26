class User < ApplicationRecord
  has_many :api_keys

  has_secure_password
end
