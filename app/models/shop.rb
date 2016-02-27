class Shop < ActiveRecord::Base
	belongs_to :user
	has_many :products, :dependent => :delete_all

	#geocoded_by :full_street_address
	#after_validation :geocode
end
