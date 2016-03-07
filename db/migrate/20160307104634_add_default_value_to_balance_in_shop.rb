class AddDefaultValueToBalanceInShop < ActiveRecord::Migration
  def change
    # balance in cents
    change_column :shops, :balance, :integer, default: 0
  end
end
