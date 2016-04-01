class Marketplace::V1::Users < Grape::API
  resource :users do
    desc "List all users"
    get do
      User.all
    end

    desc "return the information of a user"
    params do
      requires :id, :type => Integer, :desc => "user id"
    end

    route_param :id do
      get do
        User.find(params[:id])
      end
    end
  end # resource
end
