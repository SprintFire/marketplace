class Shop < ActiveRecord::Base
	belongs_to :user
	has_many :products, :dependent => :delete_all
end
