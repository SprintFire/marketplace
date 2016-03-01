class ItemsController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]
	before_action :set_supplier
	before_action :set_item, only: [:edit, :update, :destroy]

	def index
		@items = Item.all
	end

	def show
		@item = Item.find(params[:id])
	end

	def new
		@item = Item.new
	end

	def create
		@item = current_user.suppliers.find(params[:supplier_id]).items.new(item_params)
		if @item.save
			flash[:success] = "Items was successfully saved!"
			redirect_to supplier_item_path(@supplier, @item)
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @item.update(item_params)
			flash[:success] = "item was successfully updated"
			redirect_to supplier_item_path(@supplier, @item)
		else
			render 'edit'
		end
	end

	def destroy
		@item.destroy
		flash[:success] = "Item was successfully deleted."
		redirect_to dashboard_path
	end

	private

		def set_supplier
			@supplier = Supplier.find(params[:supplier_id])
		end

		def set_item
			@item = current_user.suppliers.find(params[:supplier_id]).items.find(params[:id])
		end

		def item_params
				params.require(:item).permit(:name, :item, :price, :quantity, :description)
		end
end
