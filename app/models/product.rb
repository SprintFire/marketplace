class Product < ActiveRecord::Base
  belongs_to :shop
  has_many :purchases

  acts_as_commontable

  ratyrate_rateable "quality"

end
