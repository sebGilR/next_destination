class CreateFavorites < ActiveRecord::Migration[6.0]
  def change
    create_table :favorites do |t|
      t.integer :destination_id, index: true

      t.timestamps
    end

    add_foreign_key :favorites, :destinations, column: :destination_id
  end
end
