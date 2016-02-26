class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :shops

  validates :first_name, length: {minimum: 3, maximum: 15}
end
