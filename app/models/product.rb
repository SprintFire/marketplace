class Product < ActiveRecord::Base
	belongs_to :shop
	has_many :reviews, :dependant => :destroy
end
