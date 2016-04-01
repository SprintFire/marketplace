class Marketplace::V1::Products < Grape::API
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
  end # resource :products
end
