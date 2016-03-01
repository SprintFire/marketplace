class RenameShopsToSuppliers < ActiveRecord::Migration
  def change
    rename_table :shops, :suppliers
  end
end
