class Favorite < ApplicationRecord
  validates :user_id, uniqueness: { scope: :destination_id }

  belongs_to :destination, counter_cache: true
  belongs_to :user
end
