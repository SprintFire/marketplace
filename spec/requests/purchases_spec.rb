require 'rails_helper'

RSpec.describe "Purchases", type: :request do
  describe "GET /api/v1/purchases" do
      it "Gets all purchases" do
        get '/api/v1/purchases'
        expect(JSON.parse(response.body)).to be_an_instance_of(Array)
        expect(response.body).to eq Purchase.all.to_json
        expect(response).to have_http_status(200)
      end

      it "GET /api/v1/purchases/:id" do
        purchase = create(:purchase)
        get "/api/v1/purchases/#{purchase.id}"
        expect(response.body).to eq purchase.to_json
        expect(response).to have_http_status(200)
      end
    end
end
