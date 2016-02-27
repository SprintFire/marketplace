class Purchase < ActiveRecord::Base
  belongs_to :product
  belong_to :user
end
