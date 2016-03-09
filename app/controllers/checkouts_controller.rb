class CheckoutsController < ApplicationController
  before_action :set_variables, only: [:checkout_current_card, :checkout_new_card]


  def new
    @product = Product.find(params[:id])
    @cards = current_user.cards
  end


  def checkout_current_card
    @charge = Stripe::Charge.create(
      :customer => params[:customer_id],
      :amount => @amount,
      :currency => 'eur'
    )

    record_purchase

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to root_path
  end


  def checkout_new_card
    # create the customer account on stripe
    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )

    @charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Marketplace customer',
      :currency    => 'eur'
    )

    # store the user and the customer_id from stripe so we can charge the card automatically
    card = current_user.cards.create(stripe_customer_id: customer.id, stripe_card_id: @charge[:source][:id], card_brand: @charge[:source][:brand], card_last_4: @charge[:source][:last4])

    record_purchase

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to root_path
  end



  private
  def set_variables
    @product = Product.find(params[:id])
    @shop = @product.shop
    @amount = @product.price.to_i * 100
  end

  def record_purchase

    # balance transaction information for a particular charge
    balance_transaction = Stripe::BalanceTransaction.retrieve(@charge[:balance_transaction])
    balance_after_stripe_fees = balance_transaction[:net].to_i
    balance_after_marketplace_percentage = balance_after_stripe_fees - marketplace_percentage(balance_after_stripe_fees)

    # create record of the purcase in the database
    purchase = current_user.purchases.create(product: @product,
                              purchasing_price: @product.price, purchasing_quantity: 1,
                              shop_profit: balance_after_marketplace_percentage, stripe_charge_id: @charge.id)

    flash[:success] = "Payment successfull"
    redirect_to root_path
  end

  def marketplace_percentage(cost)
    cost * 0.20 # return 20% of the cost
  end

end
