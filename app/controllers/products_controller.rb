class ProductsController < ApplicationController
	before_action :set_shop, only: [:edit, :update, :show, :destroy]
  	before_action :require_same_user, only: [:edit, :update, :destroy]

  	def index
    	@products = Product.all
  	end

	def new
		@product = Product.new
	end

	def create
    @product = Product.new(product_params)
		@product.user = current_user
		if @product.save
			flash[:success] = "Products was successfully saved!"
			redirect_to product_path(@product)
		else
			render 'new'
		end
 	end

 	def edit
  	end

	def show
	end

	def update
    if @product.update(product_params)
			flash[:success] = "product was successfully updated"
			redirect_to product_path(@product)
		else
			render 'edit'
		end
 	end

 	def destroy
 	end

  	private

	def set_product
	    @product = Product.find(params[:id])
	end

	def product_params
	    params.require(:product).permit(:name, :product, :description)
	end
end