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

  describe "DELETE /api/v1/shops/:id" do
    it "deletes a shop" do
      # user = create(:user)
      # shop = create(:shop, user: user)
      # expect{
      #   delete "/api/v1/shops/#{shop.id}", {'ACCEPT': "application/json", 'CONTENT_TYPE': 'multipart/form-data'}
      # }.to change{ Shop.count }.by(-1)
      # expect(response).to have_http_status(400)
    end
  end

  describe "POST /api/v1/shops/new" do
    it "creates a new shop" do
      user = create(:user)
      params = {name: Faker::Company.name, description: Faker::Lorem.characters(75), email_id: Faker::Internet.email, user_id: user.id}
      post '/api/v1/shops/new', params.to_json, {'ACCEPT': "application/json", 'CONTENT_TYPE': 'multipart/form-data'}
      expect(response).to have_http_status(400)
    end
  end

  describe "POST /api/v1/shops/:id/new" do
    context "without category ID" do
      it "creates a new product in the shop" do
        user = create(:user)
        shop = create(:shop, user: user)
        params = {name: Faker::Commerce.product_name, description: Faker::Lorem.characters(140), price: Faker::Commerce.price, quantity: Faker::Number.number(3)}
        post "/api/v1/shops/#{shop.id}/new", params.to_json, {'ACCEPT': "application/json", 'CONTENT_TYPE': 'multipart/form-data'}
        expect(response).to have_http_status(400)
      end
    end

    context "with category ID" do
      it "creates a new product in the shop" do
        user = create(:user)
        shop = create(:shop, user: user)
        category = create(:category)
        params = {name: Faker::Commerce.product_name, description: Faker::Lorem.characters(140), price: Faker::Commerce.price, quantity: Faker::Number.number(3), category_id: category.id}
        post "/api/v1/shops/#{shop.id}/new", params.to_json, {'ACCEPT': "application/json", 'CONTENT_TYPE': 'multipart/form-data'}
        expect(response).to have_http_status(400)
      end
    end
  end
end
