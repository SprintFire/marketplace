class Shop < ActiveRecord::Base
	belongs_to :user
	has_many :products

	mount_uploader :profile_image, UserProfileUploader
	mount_uploader :header_image, UserHeaderImageUploader
end
