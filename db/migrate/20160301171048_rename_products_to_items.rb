class RenameProductsToItems < ActiveRecord::Migration
  def change
    rename_table :products, :items
  end
end
