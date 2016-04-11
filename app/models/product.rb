class Product < ActiveRecord::Base
  belongs_to :shop
  has_many :purchases
  belongs_to :category
  validates :category, presence: true

  validates :name, length: {minimum: 2}, presence: true
  validates :price, presence: true
  validates :quantity, presence: true
  validates :description, length: {minimum: 2}, presence: true

  acts_as_commontable

  paginates_per 10

  ratyrate_rateable "quality"
end
