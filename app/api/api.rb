class API < Grape::API
  format :json
  prefix 'api'
  # version 'v1', using: :path
  # mount User::Data

  resource :users do
    desc "List all users"
    get do
      User.all
    end

    desc "return a user information"
    params do
        requires :id, :type => Integer, :desc => "user id"
    end
    route_param :id do
        get do
            User.find(params[:id])
        end
    end
  end
end
