class Marketplace::V1::Shops < Grape::API
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
  end # resource
end
