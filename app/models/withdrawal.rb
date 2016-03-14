class Withdrawal < ActiveRecord::Base
  belongs_to :shop
  scope :unapproved, -> { where(approved: false)}
  validate :only_make_withdrawal_if_you_have_balance

  def only_make_withdrawal_if_you_have_balance
    current_balance = WithdrawalsHelper.get_current_balance(shop)

    if amount > current_balance || amount < 0.01
      errors.add(:amount, "You don't have the necessary funds to withdraw that amount")
    end
  end
end
