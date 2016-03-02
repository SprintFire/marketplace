class PagesController < ApplicationController
  def home
  end

  def dashboard
  	@shops = current_user.shops
    @purchases = current_user.purchases.all
  end

end
