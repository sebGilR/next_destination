class AddCounterColumn < ActiveRecord::Migration[6.0]
  def change
    add_column :destinations, :favorites_count, :integer
  end
end
