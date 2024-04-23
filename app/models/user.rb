class User < ApplicationRecord
  before_create :generate_api_key

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true
  validates :password, confirmation: true, on: :create
  validates :api_key, uniqueness: true

  has_secure_password

  private

  def generate_api_key
    self.api_key = SecureRandom.hex(16)
  end
end

# , message: "must be a valid email address"