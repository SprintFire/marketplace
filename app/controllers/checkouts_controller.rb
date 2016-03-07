class CheckoutsController < ApplicationController
  def new
    @product = Product.find(params[:id])
  end

  def create
    # get the product from the params
    product = Product.find(params[:id])

    # multiply by 100 since stripe holds 1 as a cent.
    @amount = product.price.to_i * 100

    # create the customer account on stripe
    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )

    # store the user and the customer_id from stripe so we can charge the card automatically
    card = Card.create(user: current_user, stripe_customer_id: customer.id)

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Marketplace customer',
      :currency    => 'eur'
    )

    p charge

    purchase = Purchase.create(user: current_user, product: product, purchasing_price: product.price, purchasing_quantity: 1, stripe_charge_id: charge.id)

    redirect_to root_path
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to root_path
  end

end
