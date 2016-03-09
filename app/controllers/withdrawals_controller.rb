class WithdrawalsController < ApplicationController
  def new
    @shop = current_user.shops.find(params[:shop_id])
    @overall_balance = WithdrawalsHelper.get_shop_overall_balance(@shop)
    @withdrawal_balance = WithdrawalsHelper.get_withdrawal_balance(@shop)
    @current_balance = @overall_balance - @withdrawal_balance
    @withdrawal = Withdrawal.new
  end

  def create
    shop = current_user.shops.find(params[:withdrawal][:shop_id])
    withdrawal_amount = (params[:withdrawal][:amount].to_i * 100).abs # get absolute value so user can't enter negative numbers
    current_balance = WithdrawalsHelper.get_current_balance(shop)

    if withdrawal_amount > current_balance
      flash[:danger] = "You can't withdraw more than you own"
    else
      flash[:sucess] = "Withdrawal successfull"

      # save withdrawal
      Withdrawal.create(amount: withdrawal_amount, shop: shop)
    end

    redirect_to new_shop_withdrawal_path(shop)
  end

  private
  def withdrawals_params
    params.require(:withdrawal).permit(:amount, :shop_id)
  end
end
