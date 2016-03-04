class AddHeaderImageToShops < ActiveRecord::Migration
  def change
    add_column :shops, :header_image, :string
  end
end
