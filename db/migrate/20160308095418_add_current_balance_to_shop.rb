class AddCurrentBalanceToShop < ActiveRecord::Migration
  def change
    # shops current balance in cents on account at present
    add_column :shops, :current_balance, :integer, default: 0
  end
end
