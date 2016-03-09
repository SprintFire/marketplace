class AddBalanceToShop < ActiveRecord::Migration
  def change
    add_column :shops, :balance, :integer
  end
end
