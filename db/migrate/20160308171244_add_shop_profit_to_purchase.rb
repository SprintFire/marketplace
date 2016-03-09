class AddShopProfitToPurchase < ActiveRecord::Migration
  def change
    # this is the profit the shop makes after stripe and markeplace fees have been deducted
    add_column :purchases, :shop_profit, :integer, default: 0
  end
end
