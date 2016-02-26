class ShopsController < ApplicationController
	before_action :set_user_shop, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, exclude: [:index, :show]

	def index
		@shops = Shop.all
	end

	def show
		@shop = Shop.find(params[:id])
	end

	def new
		@shop = current_user.shops.new
	end

	def create
    @shop = current_user.shops.new(shop_params)
		if @shop.save
			flash[:success] = "Your shop was successfully created."
			redirect_to shop_path(@shop)
		else
			render 'new'
		end
 	end

 	def edit
  end

 	def update
    if @shop.update(shop_params)
			flash[:success] = "Shop was successfully updated."
			redirect_to shop_path(@shop)
		else
			render 'edit'
		end
 	end

 	def destroy
 	end

  private

		def set_user_shop
		  @shop = current_user.shops.find(params[:id])
		end

		def shop_params
		    params.require(:shop).permit(:name, :description, :facebook_url, :twitter_username, :instagram_username, :contact_phone, :email_id, :profile_image, :header_image)
		end

end
