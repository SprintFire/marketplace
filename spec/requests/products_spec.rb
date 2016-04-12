require 'rails_helper'

RSpec.describe "Products", type: :request do
  describe "GET /api/v1/products" do
    it "gets all products" do
      get '/api/v1/products'
      expect(JSON.parse(response.body)).to be_an_instance_of(Array)
      expect(response.body).to eq Product.all.to_json
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /api/v1/products/:id" do
    it "gets the information of a product" do
      user = create(:user)
      shop = create(:shop, user: user)
      product = create(:product, shop: shop)
      get "/api/v1/products/#{product.id}"
      expect(response.body).to eq product.to_json
      expect(response).to have_http_status(200)
    end
  end
end
