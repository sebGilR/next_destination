class AddImageColumnToDestinations < ActiveRecord::Migration[6.0]
  def change
    add_column :destinations, :img_url, :string, default: ''
  end
end
