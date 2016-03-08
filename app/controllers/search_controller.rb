class SearchController < ApplicationController
  def index
    if params[:shop][:latitude] && params[:shop][:longitude]
      @locations = Shop.near(get_geolocation, 50)
    else
      @locations = Shop.all
    end
  end

  private

    def get_geolocation
      [params[:shop][:latitude], params[:shop][:longitude]]
    end
end
