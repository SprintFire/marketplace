class AddLocationToShop < ActiveRecord::Migration
  def change
    add_column :shops, :longitude, :numeric
    add_column :shops, :latitude, :numeric
    add_index  :shops, [:longitude, :latitude]
  end
end
