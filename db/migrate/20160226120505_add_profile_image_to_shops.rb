class AddProfileImageToShops < ActiveRecord::Migration
  def change
    add_column :shops, :profile_image, :string
  end
end
