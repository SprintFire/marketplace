class Marketplace::API < Grape::API
  format :json
  prefix 'api'
  version 'v1', using: :path

  rescue_from Grape::Exceptions::ValidationErrors do |e|
    rack_response({
      status:    e.status,
      error_msg: e.message,
    }.to_json, 400)
  end

  mount Marketplace::V1::Base
end
