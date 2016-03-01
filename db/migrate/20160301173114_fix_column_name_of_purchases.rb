class FixColumnNameOfPurchases < ActiveRecord::Migration
  def change
    rename_column :purchases, :product_id, :item_id
  end
end
