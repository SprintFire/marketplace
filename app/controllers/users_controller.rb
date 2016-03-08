class UsersController < ApplicationController

  def edit
    @user = current_user
    @cards = Card.where(user: current_user)
  end

  def update
    @user = current_user

    if @user.update(user_params)
      flash[:success] = "Your account has been successfully updated!"
      render 'edit'
    else
      render 'edit'
    end
  end

  def delete_card
    customer = Stripe::Customer.retrieve(params[:customer_id])
    customer.sources.retrieve(params[:card_id]).delete

    current_user.cards.find_by(stripe_card_id: params[:card_id]).destroy

    flash[:success] = "Card deleted!"
    redirect_to account_path
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name)
  end
end
