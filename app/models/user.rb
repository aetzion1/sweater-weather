class User < ApplicationRecord
  validates :email, uniqueness: { case_sensitive: false }, presence: true
  validates_presence_of :password, require: true
  validates_presence_of :secure_password, require: true
  # validates_presence_of :api_key, uniqueness: true, require: true
  has_secure_password

  before_save { email.downcase! }
  before_create :set_api_key

  def set_api_key
    self.api_key = generate_api_key
  end
end
