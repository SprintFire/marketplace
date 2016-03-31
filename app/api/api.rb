class API < Grape::API
  format :json
  prefix 'api'

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
  end

  resource :shops do
    desc "List all shops"
    get do
      Shop.all
    end

    desc "return the information of a shop "
    params do
        requires :id, :type => Integer, :desc => "shop id"
    end
    route_param :id do
        get do
            Shop.find(params[:id])
        end
    end
  end

  resource :products do
    desc "List all products"
    get do
      Product.all
    end

    desc "return the information of a product"
    params do
        requires :id, :type => Integer, :desc => "product id"
    end
    route_param :id do
        get do
            Product.find(params[:id])
        end
    end
  end
end
