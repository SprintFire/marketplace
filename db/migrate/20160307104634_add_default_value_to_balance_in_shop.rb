class AddDefaultValueToBalanceInShop < ActiveRecord::Migration
  def change
    # overall acumulated balance in cents for shop
    change_column :shops, :balance, :integer, default: 0
  end
end
