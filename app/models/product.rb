class Product < ActiveRecord::Base
	belongs_to :shop
	has_many :comments
	has_many :purchases
end
