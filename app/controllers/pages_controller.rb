class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:dashboard]

  def home
  end

  def dashboard
    @shops = current_user.shops
    @purchases = current_user.purchases.all
  end

end
