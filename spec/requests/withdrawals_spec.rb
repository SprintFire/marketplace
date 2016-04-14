require 'rails_helper'

RSpec.describe "Withdrawals", type: :request do

  describe "GET /api/v1/withdrawals" do
    it "Gets all withdrawals" do
      get '/api/v1/withdrawals'
      expect(JSON.parse(response.body)).to be_an_instance_of(Array)
      expect(response.body).to eq Withdrawal.all.to_json
      expect(response).to have_http_status(200)
    end

    it "GET /api/v1/withdrawals/:id" do
      user = create(:user, email: "example@example.com")
      shop = create(:shop, user: user)
      product = create(:product, shop: shop)
      purchase = create(:purchase, product: product)
      withdrawal = create(:withdrawal, shop: shop)
      get "/api/v1/withdrawals/#{withdrawal.id}"
      expect(response.body).to eq withdrawal.to_json
      expect(response).to have_http_status(200)

    end
  end
end
