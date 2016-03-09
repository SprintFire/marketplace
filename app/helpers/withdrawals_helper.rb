module WithdrawalsHelper

  def self.get_shop_overall_balance(shop)
    total = 0

    Purchase.where(product: shop.products).each do |purchase|
      total += purchase.shop_profit
    end

    return total
  end

  def self.get_withdrawal_balance(shop)
    total = 0

    Withdrawal.where(shop: shop).each do |withdrawal|
      total += withdrawal.amount
    end

    return total
  end

  def self.get_current_balance(shop)
    WithdrawalsHelper.get_shop_overall_balance(shop) - WithdrawalsHelper.get_withdrawal_balance(shop)
  end

end
