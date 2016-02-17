class PagesController < ApplicationController
  def home
  end

  def dashboard
  	user = current_user
  	@shop = user.shop
  end

end
