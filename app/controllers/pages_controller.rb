class PagesController < ApplicationController
  def home
  end

  def dashboard
  	@shops = current_user.shops
  end

end
