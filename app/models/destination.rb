class Destination < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 }
  validates :description, presence: true

  has_many :favorites, dependent: :destroy

  scope :order_by_most_favorites, -> { order(favorites_count: :desc) }
  scope :order_by_least_favorites, -> { order(favorites_count: :asc) }
end
