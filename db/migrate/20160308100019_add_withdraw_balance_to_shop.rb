class AddWithdrawBalanceToShop < ActiveRecord::Migration
  def change
    # the amount a shop owner has taken from his balance in his shop in cents.
    add_column :shops, :withdraw_balance, :integer, default: 0
  end
end
