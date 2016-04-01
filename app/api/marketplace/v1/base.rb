module Marketplace
  module V1
    class Base < Grape::API
      version 'v1', using: :path

      mount Marketplace::V1::Users
      mount Marketplace::V1::Shops
      mount Marketplace::V1::Products
      mount Marketplace::V1::Categories
    end # class
  end # module V1
end # moducle Marketplace
