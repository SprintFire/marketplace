module ApplicationHelper
  def shop_balance_in_euros(balance_in_cents)
    balance_in_cents / 100.00
  end
end
