class SearchController < ApplicationController
  def index
    if params[:search]
      @shops = Shop.near([params[:search][:lat], params[:search][:lng]], 50)
    else
      @shops = Shop.all
    end

    @shop_locations = @shops.to_json(only: [:name, :latitude, :longitude, :id, :address])
  end
end
