class Category < ActiveRecord::Base
  has_many :products

  extend FriendlyId
  friendly_id :title, use: :slugged
end
