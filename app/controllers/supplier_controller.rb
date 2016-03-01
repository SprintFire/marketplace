class SuppliersController < ApplicationController
	before_action :set_user_supplier, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, exclude: [:index, :show]

	def index
		@suppliers = Supplier.all
	end

	def show
		@supplier = Supplier.find(params[:id])
	end

	def new
		@supplier = current_user.suppliers.new
	end

	def create
    @supplier = current_user.suppliers.new(supplier_params)
		if @supplier.save
			flash[:success] = "Your supplier was successfully created."
			redirect_to supplier_path(@supplier)
		else
			render 'new'
		end
 	end

 	def edit
  end

 	def update
    if @supplier.update(supplier_params)
			flash[:success] = "Your supplier was successfully updated."
			redirect_to supplier_path(@supplier)
		else
			render 'edit'
		end
 	end

 	def destroy
		@supplier = current_user.suppliers.find(params[:id])
		@supplier.destroy
		flash[:info] = "Your supplier was successfully deleted."
		redirect_to dashboard_path
 	end

  private

		def set_user_supplier
		  @supplier = current_user.suppliers.find(params[:id])
		end

		def supplier_params
		    params.require(:supplier).permit(:name, :description, :facebook_url, :twitter_username, :instagram_username, :contact_phone, :email_id, :latitude, :longitude)
		end

end
