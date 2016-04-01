module Marketplace
  module V1
    class Base < Grape::API
      version 'v1', using: :path

      rescue_from ActiveRecord::RecordNotFound do |e|
        error!({ error_code: 404, error_messages: e.message }, 404)
      end

      mount Marketplace::V1::Users
      mount Marketplace::V1::Shops
      mount Marketplace::V1::Products
      mount Marketplace::V1::Categories
      mount Marketplace::V1::AdminUsers
      mount Marketplace::V1::Purchases
      mount Marketplace::V1::Withdrawals
    end # class
  end # module V1
end # moducle Marketplace
