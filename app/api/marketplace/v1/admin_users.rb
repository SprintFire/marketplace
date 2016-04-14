class Marketplace::V1::AdminUsers < Grape::API
  resource :admin_users do
    desc "List all admin users"
    get do
      AdminUser.all
    end

    desc "return the information of an admin user"
    params do
      requires :id, :type => Integer, :desc => "user id"
    end

    route_param :id do
      get do
        AdminUser.find(params[:id])
      end
    end
  end # resource
end
