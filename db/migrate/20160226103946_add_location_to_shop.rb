class AddLocationToShop < ActiveRecord::Migration
  def change
    add_column :shops, :longitude, :numeric
    add_column :shops, :latitude, :numeric
  end
end
