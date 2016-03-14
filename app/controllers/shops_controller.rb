class ShopsController < ApplicationController
  before_action :set_user_shop, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  add_breadcrumb "Dashboard", :dashboard_path
  add_breadcrumb "Shops", :shops_path

  def index
    if params[:search]
      @shops = Shop.near([search_params[:lat], search_params[:lng]], 50)
    else
      @shops = Shop.all
    end
  end

  def show
    @shop = Shop.find(params[:id])
    add_breadcrumb "#{@shop.name}", shop_path(@shop), title: "Testing"
  end

  def new
    @shop = current_user.shops.new
    add_breadcrumb "New Shop", :new_shop_path
  end

  def create
    @shop = current_user.shops.new(shop_params)
    if @shop.save
      ConfirmationMailer.successfull_shop_creation(@shop, current_user).deliver_later
      flash[:success] = 'Your shop was successfully created.'
      redirect_to shop_path(@shop)
    else
      render 'new'
    end
  end

  def edit
    add_breadcrumb "#{@shop.name}", shop_path(@shop)
    add_breadcrumb "Edit", edit_shop_path(@shop)
  end

  def update
    if @shop.update(shop_params)
      flash[:success] = 'Your shop was successfully updated.'
      redirect_to shop_path(@shop)
    else
      render 'edit'
    end
  end

  def destroy
    @shop = current_user.shops.find(params[:id])
    @shop.destroy
    flash[:info] = 'Your shop was successfully deleted.'
    redirect_to dashboard_path
  end

  private

    def set_user_shop
      @shop = current_user.shops.find(params[:id])
    end

    def shop_params
      params.require(:shop).permit(:name, :description, :facebook_url, :twitter_username, :instagram_username, :contact_phone, :email_id, :latitude, :longitude, :profile_image, :header_image)
    end

    def search_params
      params.require(:search).permit(:text, :lat, :lng)
    end

end
