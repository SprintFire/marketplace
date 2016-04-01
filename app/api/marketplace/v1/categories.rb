class Marketplace::V1::Categories < Grape::API
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
    end # route_param
  end # resource
end
