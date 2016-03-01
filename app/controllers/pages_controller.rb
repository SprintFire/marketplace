class PagesController < ApplicationController
  def home
  end

  def dashboard
  	@suppliers = current_user.suppliers
  end

end
