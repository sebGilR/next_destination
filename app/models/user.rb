class User < ApplicationRecord
  validates :username, presence: true, length: {minimum: 3, maximum: 20}, uniqueness: true
  validates :password_digest, presence: true

  has_many :favorites, dependent: :destroy
end