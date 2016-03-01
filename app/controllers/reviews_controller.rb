class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def create
    @review = Review.new(comment_params)
    @review.user = current_user
    if @review.save
      flash[:success] = "Comment successful."
      redirect_to shop_product_path(@product.shop, @product)
    end

    @star_rating = @product.star_rating.new :value => params[:value]
    if @star_rating.save
      flash[:success] = "Rating successful."
      redirect_to shop_product_path(@product.shop, @product)
    else
      flash[:success] = "Something went wrong."
      redirect_to shop_product_path(@product.shop, @product)
    end
  end

  def edit
	end

	def update
		if @review.update(update_comment_params)
			flash[:success] = "Your comment was successfully updated"
			redirect_to shop_product_path(@shop, @product)
		end

    @star_rating = Review.star_rating.find(params[:id])
    @star_rating.update_attribute :value, params[:value]
	end

	def destroy
		@review.destroy
		flash[:success] = "Your comment was successfully deleted."
		redirect_to shop_product_path(@shop, @product)
	end


  private

  def set_product
    @product = Product.find(parms[:product_id])
  end

  def comment_params
    params.require(:review).permit(:product_id, :star_rating, :comment)
  end

  def update_comment_params
    params.require(:review).permit(:star_rating, :comment)
  end

  def check_review
    if current_user.reviews.eists?(user_id: current_user.id)
      def update
      end
    end
  end


end
