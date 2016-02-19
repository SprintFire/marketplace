class PagesController < ApplicationController
  def home
  end

  def dashboard
  	@shop = current_user.shops
  end

end
