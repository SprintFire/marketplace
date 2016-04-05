module Marketplace
  module V1
    class Base < Grape::API
      version 'v1', using: :path

      rescue_from ActiveRecord::RecordNotFound do |e|
        error!({ error_code: 404, error_messages: e.message }, 404)
      end

      helpers do
        def authenticate!
          payload = TokenProvider.decrypted_token(token)
          user_id = payload[0]['user_id']
          @current_user = User.find(user_id)
        rescue
          error!('Unauthorized', 401)
        end
        def current_user
          @current_user ||= authenticate!
        end
        def token
          request.headers['Authorization'].split(' ').last
        end
        def render_401_error(resource)
          error!({ error_code: 401, error_messages: resource.errors.full_messages }, 401)
        end
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
