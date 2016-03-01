class ProductsController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]
	before_action :set_shop
	before_action :set_product, only: [:edit, :update, :destroy]

	def index
		@products = Product.all
	end

	def show
		@product = Product.find(params[:id])
		@review = Review.new 
	end

	def new
		@product = Product.new
	end

	def create
		@product = current_user.shops.find(params[:shop_id]).products.new(product_params)
		if @product.save
			flash[:success] = "Products was successfully saved!"
			redirect_to shop_product_path(@shop, @product)
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @product.update(product_params)
			flash[:success] = "product was successfully updated"
			redirect_to shop_product_path(@shop, @product)
		else
			render 'edit'
		end
	end

	def destroy
		@product.destroy
		flash[:success] = "Product was successfully deleted."
		redirect_to dashboard_path
	end

	private

		def set_shop
			@shop = Shop.find(params[:shop_id])
		end

		def set_product
			@product = current_user.shops.find(params[:shop_id]).products.find(params[:id])
		end

		def product_params
				params.require(:product).permit(:name, :product, :price, :quantity, :description)
		end
end
