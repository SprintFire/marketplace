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

  mount Marketplace::V1::Base
end
