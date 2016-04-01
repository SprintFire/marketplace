class UsersController < ApplicationController

  add_breadcrumb "Dashboard", :dashboard_path
  add_breadcrumb "My Account", :account_path

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

  def add_card 
    # create the customer account on stripe
    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )
    # store the user and the customer_id from stripe so we can charge the card automatically
    card = current_user.cards.create(stripe_customer_id: customer.id, stripe_card_id: customer[:sources][:data][0][:id], card_brand: customer[:sources][:data][0][:brand], card_last_4: customer[:sources][:data][0][:last4])

    redirect_to :edit
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to root_path
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name)
  end
end
