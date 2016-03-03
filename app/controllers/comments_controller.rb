class CommentsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @product = Product.find(params[:product_id])
    @shop = @product.shop
    @comment = @product.comments.create(params[:comment])

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @product, notice: 'Comment was successfully created.' }
        format.json { render json: @comment, status: :created, location: @comment }
      else
        format.html { render action: "new" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end

  end

  # PUT /comments/1
  # PUT /comments/1.json
  end
