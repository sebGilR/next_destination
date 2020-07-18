class User < ApplicationRecord
  validates :username, presence: true, length: {minimum: 3, maximum: 20}, uniqueness: true
  has_secure_password

  has_many :favorites, dependent: :destroy
end
