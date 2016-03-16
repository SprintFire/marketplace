class Withdrawal < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper
  belongs_to :shop
  scope :pending, -> { where(approved: false)}
  validate :only_make_withdrawal_if_you_have_balance

  def only_make_withdrawal_if_you_have_balance
    current_balance = WithdrawalsHelper.get_current_balance(shop)

    if amount > current_balance || amount < 0.01
      errors.add(:amount, "You don't have the necessary funds to withdraw that amount")
    end
  end

  def amount_decimal
    number_with_precision(amount / 100.00, precision: 2)
  end
end
