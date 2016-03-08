class SearchController < ApplicationController
  def index
    if params[:search].present?
      @locations = Shop.near(params[:search], 50, :order => :distance)
    else
      @locations = Shop.all
    end
  end
end
