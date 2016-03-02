class Review < ActiveRecord::Base
  belongs_to :product
  belongs_to :user
  # validates_presence_of :product
  # validates_inclusion_of :value, :in => 1..5
end
