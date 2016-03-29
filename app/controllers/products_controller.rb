class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_shop
  before_action :set_shop_user_product, only: [:edit, :update, :destroy]

  add_breadcrumb "Dashboard", :dashboard_path
  add_breadcrumb "Shops", :shops_path
  add_breadcrumb "Products", :shop_products_path

  def index
    @products = @shop.products.page params[:page]
  end

  def show
    @product = @shop.products.find(params[:id])
    commontator_thread_show(@product)
    add_breadcrumb "#{@product.name}", shop_product_path(@product.shop.id, @product.id)
  end

  def new
    @product = current_user.shops.find(params[:shop_id]).products.new
    add_breadcrumb "New Product", :new_shop_product_path
    @categories = Category.all
  end

  def create
    @product = current_user.shops.find(params[:shop_id]).products.new(product_params)
    @categories = Category.all
    if @product.save
      flash[:success] = 'Products was successfully saved!'
      redirect_to shop_product_path(@shop, @product)
    else
      render 'new'
    end
  end

  def edit
    add_breadcrumb "#{@product.name}", shop_product_path(@shop, @product)
    add_breadcrumb "Edit", edit_shop_product_path(@shop, @product)
  end

  def update
    if @product.update(product_params)
      flash[:success] = 'Product was successfully updated!'
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

    def set_shop_user_product
      @product = current_user.shops.find(params[:shop_id]).products.find(params[:id])
    end

    def product_params
        params.require(:product).permit(:name, :product, :price, :quantity, :description, :category_id)
    end
end
