class Product < ActiveRecord::Base
  belongs_to :shop
  has_many :purchases

  validates :name, length: {minimum: 2, maximum: 15}, presence:true
  validates :price, presence:true
  validates :quantity, presence:true
  validates :description, length: {minimum: 2}, presence:true

  acts_as_commontable

  ratyrate_rateable "quality"

end
