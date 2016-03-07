class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:dashboard]

  def home
  end

  def dashboard
    @shops = current_user.shops
    @purchases = current_user.purchases.all
  end

  def terms_and_conditions

  end

  def about_us

  end

  def privacy_policy
    
  end

end
