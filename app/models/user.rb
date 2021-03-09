class User < ApplicationRecord
  validates :email, uniqueness: { case_sensitive: false }, presence: true
  validates_presence_of :password
  validates_presence_of :password_confirmation
  validates :password, confirmation: { case_sensitive: true }

  has_secure_password
  has_secure_token :api_key

  before_save { email.downcase! }
end
