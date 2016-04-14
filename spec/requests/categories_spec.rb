require 'rails_helper'

RSpec.describe "Categories", type: :request do
  describe "GET /api/v1/categories" do
    it "gets all shops" do
      get '/api/v1/categories'
      expect(JSON.parse(response.body)).to be_an_instance_of(Array)
      expect(response.body).to eq Category.all.to_json
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /api/v1/categories/:id" do
    it "gets the information of a category" do
      category = create(:category)
      get "/api/v1/categories/#{category.id}"
      expect(response.body).to eq category.to_json
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /api/v1/categories/:id/products" do
    it "gets all products of a category" do
      user = create(:user)
      shop = create(:shop, user: user)
      category = create(:category)
      product = create(:product, shop: shop, category_id: category.id)
      get "/api/v1/categories/#{category.id}/products"
      expect(response.body).to eq Product.where(category_id: category.id).all.to_json
      expect(response).to have_http_status(200)
    end
  end
end
