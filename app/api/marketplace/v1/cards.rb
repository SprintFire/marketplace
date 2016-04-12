class Marketplace::V1::Cards < Grape::API
  resource :cards do
    desc "List all cards"
    get do
      Card.all
    end

    desc "return the information of a cards"
    params do
      requires :id, :type => Integer, :desc => "card id"
    end

    route_param :id do
      get do
        Card.find(params[:id])
      end
    end
  end # resource
end
