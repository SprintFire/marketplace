class ChangeProductUserIdToProductId < ActiveRecord::Migration
  def change
  	remove_column :products, :user_id
  	add_reference :products, :shop
  end
end
