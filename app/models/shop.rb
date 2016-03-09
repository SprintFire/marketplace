class Shop < ActiveRecord::Base
  belongs_to :user
  has_many :products, :dependent => :delete_all
  has_many :withdrawals
  # geocoded_by :full_street_address
  # after_validation :geocode
  geocoded_by :latitude => :latitude, :longitude => :longitude

  mount_uploader :profile_image, UserProfileUploader
  mount_uploader :header_image, UserHeaderImageUploader

  validate :picture_size

  # def search
  #   @location = params[:search]
  #   @distance = params[:miles]
  #   @shops = Shop.near(@location, @distance)
  #
  #   if @location.present?
  #     flash[:success] = 'Please enter a search term.'
  #     redirect_to "/"
  #   else
  #     if @farms.length < 1
  #       flash[:success] = 'Sorry! We could not find anything'
  #     else
  #       @locations = Location.near(params[:search], 50, :order => :distance)
  #     end
  # end

  private

  def picture_size
    if profile_image.size > 5.megabytes || header_image.size > 5.megabytes
      errors.add("Image should be less than 5MB")
    end
  end

end
