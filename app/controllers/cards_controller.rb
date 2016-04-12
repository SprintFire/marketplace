class CardsController < ApplicationController
  before_action :authenticate_user!

  def create
    # create the customer account on stripe
    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )
    # store the user and the customer_id from stripe so we can charge the card automatically
    card = current_user.cards.create(stripe_customer_id: customer.id, stripe_card_id: customer[:sources][:data][0][:id], card_brand: customer[:sources][:data][0][:brand], card_last_4: customer[:sources][:data][0][:last4])

    flash[:success] = "Card added"
    redirect_to account_path
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to account_path
  end

  def destroy

    customer = Stripe::Customer.retrieve(params[:customer_id])
    customer.sources.retrieve(params[:id]).delete

    current_user.cards.find_by(stripe_card_id: params[:id]).destroy

    flash[:success] = "Card deleted!"
    redirect_to account_path
  end

end
