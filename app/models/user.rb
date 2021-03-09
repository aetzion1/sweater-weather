class User < ApplicationRecord
  validates :email, uniqueness: { case_sensitive: false }, presence: true
  validates :password, presence: true
  validates :password_confirmation, presence: true

  has_secure_password
  has_secure_token :api_key

  before_save { email.downcase! }
end
