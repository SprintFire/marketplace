class Marketplace::V1::Purchases < Grape::API
  resource :purchases do
    desc "List all purchases"
    get do
      Purchase.all
    end

    desc "return the information of a purchase"
    params do
      requires :id, :type => Integer, :desc => "user id"
    end

    route_param :id do
      get do
        Purchase.find(params[:id])
      end
    end
  end # resource
end
