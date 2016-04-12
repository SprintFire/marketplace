require 'rails_helper'

RSpec.describe "Shops", type: :request do
  describe "GET /api/v1/shops" do
    it "gets all shops" do
      get '/api/v1/shops'
      expect(JSON.parse(response.body)).to be_an_instance_of(Array)
      expect(response.body).to eq Shop.all.to_json
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /api/v1/shops/:id" do
    it "gets the information of a shop" do
      shop = create(:shop)
      get "/api/v1/shops/#{shop.id}"
      expect(response.body).to eq shop.to_json
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /api/v1/shops/:id/products" do
    it "gets all products in a shop" do
      user = create(:user)
      shop = create(:shop, user: user)
      product = create(:product, shop: shop)
      get "/api/v1/shops/#{shop.id}/products"
      expect(response.body).to eq Product.where(shop_id: shop.id).all.to_json
      expect(response).to have_http_status(200)
    end
  end
end
