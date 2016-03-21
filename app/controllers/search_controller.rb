class SearchController < ApplicationController
  def index

    if params[:search] && (!params[:search][:lat].blank? || !params[:search][:lng].blank?)
      @shops = Shop.near([params[:search][:lat], params[:search][:lng]], 50)
      @products = @shops.map { |shop| shop.products }
    elsif params[:search] && (params[:search][:lat].blank? || params[:search][:lng].blank?) && (params[:search_category] && params[:search_category].blank?) && (params[:keyword_search] && params[:keyword_search].blank?)
      @shops = Shop.all
      @products = Product.all
    elsif params[:search] && (params[:search][:lat].blank? || params[:search][:lng].blank?)
      @shops = []
      @products = []
    else
      @shops = Shop.all
      @products = Product.all
    end

    if params[:search_category] && !params[:search_category].blank?
      # get all results from category search
      @products_from_category = Category.find(params[:search_category]).products
      @shops_with_category = @products_from_category.map{|product| product.shop }
      # merge similarities and remove duplicates
      @shops = @shops.concat(@shops_with_category).uniq
      @products = @products.concat(@products_from_category).uniq
    end

    if params[:keyword_search] && !params[:keyword_search].blank?
      # get all results from keyword search
      @products_from_keyword = Product.where('UPPER(name) LIKE UPPER(?)', "%#{params[:keyword_search]}%")
      @shops_with_keyword = @products_from_keyword.map{|product| product.shop }
      # merge similarities
      @shops = @shops.concat(@shops_with_keyword).uniq
      @products = @products.concat(@products_from_keyword).uniq
    end


    @shop_locations = @shops.to_json(only: [:name, :latitude, :longitude, :id, :address, :header_image])
  end
end
