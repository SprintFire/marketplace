class SearchController < ApplicationController
  def index

    if params[:search] && (!params[:search][:lat].blank? || !params[:search][:lng].blank?)
      @shops = Shop.near([params[:search][:lat], params[:search][:lng]], 50)
      @products = @shops.map{|shop| shop.products}.flatten.uniq
    else
      @shops = Shop.all
      @products = Product.all
    end

    if params[:search_category] && !params[:search_category].blank?
      @products_from_category = Category.find(params[:search_category]).products
      # find all shop with that product category
      @shops_with_category = @products_from_category.map{|product| product.shop }
      # merge similarities and remove duplicates
      @shops = (@shops & @shops_with_category).flatten.uniq
      @products = (@products & @products_from_category).flatten.uniq
    end

    if params[:keyword_search] && !params[:keyword_search].blank?
      # just keyword entered
      @products_from_keyword = Product.where('UPPER(name) LIKE UPPER(?)', "%#{params[:keyword_search]}%")
      @shops_with_keyword = @products_from_keyword.map{|product| product.shop }
      @shops = (@shops & @shops_with_keyword).flatten.uniq
      @products = (@products & @products_from_keyword).flatten.uniq
    end


    @shop_locations = @shops.to_json(only: [:name, :latitude, :longitude, :id, :address, :header_image])
  end
end
