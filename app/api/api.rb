class API < Grape::API
  format :json
  prefix 'api'
  version 'v1', using: :path

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

    desc "return the information of a shop"
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

  resource :categories do
    desc "List all categories"
    get do
      Category.all
    end

    desc "return the information of a category"
    params do
        requires :id, :type => Integer, :desc => "category id"
    end
    route_param :id do
        get do
            Category.find(params[:id])
        end

        resource :products do
          desc "List all products in given category"
          get do
            Product.where(category_id: params[:id]).all
          end
        end
    end
  end
end
