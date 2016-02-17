class Shop < ActiveRecord::Base
	belongs_to :user
	has_many :product
end
