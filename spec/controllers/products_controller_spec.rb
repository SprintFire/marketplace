require 'rails_helper'

RSpec.describe ProductsController, type: :controller do

  describe "Products controller" do
    login_user
    it "goes to all product page" do
      shop = create(:shop, user: subject.current_user)
      p shop
      get :index, shop_id: shop.id
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "goes to the creating product page" do
      shop = create(:shop, user: subject.current_user)
      p shop
      get :new, shop_id: shop.id
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "creates a product" do
      shop = create(:shop, user: subject.current_user)
      product = attributes_for(:product, shop: shop)
      p shop
      p product
      post :create, { shop_id: shop.id, product: product }
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "shows the specified product" do
      shop = create(:shop, user: subject.current_user)
      product = create(:product, shop: shop)
      p shop
      p product
      get :show, { shop_id: shop.id, id: product.id }
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end
end
