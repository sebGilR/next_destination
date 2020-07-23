class AddIndexToFavorites < ActiveRecord::Migration[6.0]
  def change
    add_index :favorites, :user_id
    add_foreign_key :favorites, :users, column: :user_id
  end
end
