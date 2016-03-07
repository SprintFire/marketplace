class PagesController < ApplicationController
  before_action :authenticate_user!, exclude: [:home]

  def home
  end

  def dashboard
    @shops = current_user.shops
    @purchases = current_user.purchases.all
  end

end
