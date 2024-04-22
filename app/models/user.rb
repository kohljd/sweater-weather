class User < ApplicationRecord
  validates :email, presence: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: 'Must be a valid email address'}

  has_secure_password
end
