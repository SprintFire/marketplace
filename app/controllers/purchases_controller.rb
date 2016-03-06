class PurchasesController < ApplicationController
  before_action :authenticate_user!

  def index
    @purchases = current_user.purchases.all
  end

  def create
    @product = Product.find(params[:id])
    @purchase = current_user.purchases.new(product: @product)
    if @purchase.save
      flash[:success] = "Your purchase was successful!"
      redirect_to shop_product_path(@product.shop, @product)
    end
  end

end
