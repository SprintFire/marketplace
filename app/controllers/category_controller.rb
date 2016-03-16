class CategoryController < ApplicationController
  def show
    @category = Category.friendly.find(params[:id])
    @products = Product.where(category_id: @category.id)
  end
end
