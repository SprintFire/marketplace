class Marketplace::API < Grape::API
  format :json
  prefix 'api'

  rescue_from Grape::Exceptions::ValidationErrors do |e|
    rack_response({
      status:    e.status,
      error_msg: e.message,
    }.to_json, 400)
  end

  rescue_from ActionController::RoutingError do |e|
    error!({ error_code: 404, error_messages: e.message }, 404)
  end

  helpers do
    def current_user
      user = User.where(authentication_token: params[:auth_token], is_approved: true).first
      if user
        @current_user = user
      else
        false
      end
    end

    def authenticate!
      error!('401 Unauthorized', 401) unless current_user
    end
  end

  mount Marketplace::V1::Base
end
