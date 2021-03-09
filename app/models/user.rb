class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true
  validates_presence_of :password, require: true
  validates_presence_of :api_key, uniqueness: true, require: true

  has_secure_password
end
