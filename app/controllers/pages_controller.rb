class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:dashboard]

  layout "dashboard", only: [:dashboard]

  def home
  end

  def dashboard
    @shops = current_user.shops
    @purchases = current_user.purchases.all
    add_breadcrumb "Dashboard", :dashboard_path
  end

end
