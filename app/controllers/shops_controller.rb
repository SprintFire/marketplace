class ShopsController < ApplicationController
	before_action :set_shop, only: [:edit, :update, :show, :destroy]
  	before_action :require_same_user, only: [:edit, :update, :destroy]

	def new
		@shop = Shop.new
	end

	def create
    @shop = Shop.new(shop_params)
		@shop.user = current_user
		if @shop.save
			flash[:success] = "Your shop was successfully created"
			redirect_to shop_path(@shop)
		else
			render 'new'
		end
 	end

 	def edit
  	end

	def show
	end

 	def update
    if @shop.update(shop_params)
			flash[:success] = "Shop was successfully updated"
			redirect_to shop_path(@shop)
		else
			render 'edit'
		end
 	end

 	def destroy
 	end

  	private

	def set_shop
	    @shop = Shop.find(params[:id])
	end

	def shop_params
	    params.require(:shop).permit(:name, :shop, :description)
	end


end