class Marketplace::V1::Withdrawals < Grape::API
  resource :withdrawals do
    desc "List all withdrawals"
    get do
      Withdrawal.all
    end

    desc "return the information of a withdrawal"
    params do
      requires :id, :type => Integer, :desc => "user id"
    end

    route_param :id do
      get do
        Withdrawal.find(params[:id])
      end
    end
  end # resource
end
