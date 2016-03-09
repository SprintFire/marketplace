class RenameColumnNamesForProduct < ActiveRecord::Migration
  def change
    rename_column :purchases, :purchasing_price, :price
    rename_column :purchases, :purchasing_quantity, :quantity
  end
end
