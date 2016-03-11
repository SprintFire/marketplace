class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:dashboard]

  add_breadcrumb "Dashboard", :dashboard_path
  def home
  end

  def dashboard
    @shops = current_user.shops
    @purchases = current_user.purchases.all
  end

end
