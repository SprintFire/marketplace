class WithdrawalsController < ApplicationController
  before_action :set_shop, except: [:index]

  add_breadcrumb "Withdrawals", :withdrawals_path


  def index
    @shops = current_user.shops
  end

  def new
    @overall_balance = WithdrawalsHelper.get_shop_overall_balance(@shop)
    @withdrawal_balance = WithdrawalsHelper.get_withdrawal_balance(@shop)
    @current_balance = @overall_balance - @withdrawal_balance
    @withdrawal = Withdrawal.new
    add_breadcrumb "New Withdrawals", new_shop_withdrawal_path(@shop)
  end

  def create
    withdrawal_amount = (withdrawals_params[:amount].to_f * 100).abs # get absolute value so user can't enter negative numbers

    @withdrawal = Withdrawal.new(amount: withdrawal_amount, shop: @shop)
    if @withdrawal.save
      flash[:sucess] = "Withdrawal request sent"

    else
      flash[:danger] = "You can't withdraw more than you own"
    end

    redirect_to new_shop_withdrawal_path(@shop)
  end

  private
  def withdrawals_params
    params.require(:withdrawal).permit(:amount, :shop_id)
  end

  def set_shop
    @shop = current_user.shops.find(params[:shop_id])
  end
end
