class Marketplace::V1::AdminUsers < Grape::API
  resource :admin_users do
    desc "List all admin users"
    get do
      # AdminUsers.all
    end
  end
end
