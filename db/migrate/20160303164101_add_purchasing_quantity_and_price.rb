class AddPurchasingQuantityAndPrice < ActiveRecord::Migration
  def change
    add_column :purchases, :purchasing_quantity, :integer
    add_column :purchases, :purchasing_price, :numeric
  end
end
