class RemoveFieldsFromShop < ActiveRecord::Migration
  def change
    remove_column :shops, :balance
    remove_column :shops, :current_balance
    remove_column :shops, :withdraw_balance
  end
end
