class AddDefaultFavoriteCount < ActiveRecord::Migration[6.0]
  def change
    change_column :destinations, :favorites_count, :integer, default: 0
  end
end
