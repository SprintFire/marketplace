require 'rails_helper'

RSpec.describe ProductsController, type: :controller do

  describe "Logged in user" do
    login_user
    before :each do
      @shop = create(:shop, user: subject.current_user)
      p @shop
    end

    it "goes to all product page" do
      get :index, shop_id: @shop.id
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "goes to the creating product page" do
      get :new, shop_id: @shop.id
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "creates a product" do
      product = attributes_for(:product, shop: @shop)
      p product
      post :create, { shop_id: @shop.id, product: product }
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "shows the specified product" do
      product = create(:product, shop: @shop)
      p product
      get :show, { shop_id: @shop.id, id: product.id }
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "goes to the editing product page" do
      product = create(:product, shop: @shop)
      p product
      get :edit, { shop_id: @shop.id, id: product.id }
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "updates the product information" do
      product = create(:product, shop: @shop)
      put :update, { shop_id: @shop.id, id: product.id, product: product.attributes = { name: 'New name' } }
      product.reload
      p product
      expect(response).to redirect_to shop_product_path
      expect(response).to have_http_status(302)
    end

    it "deletes the product" do
      product = create(:product, shop: @shop)
      delete :destroy, { shop_id: @shop.id, id: product.id }
      expect(response).to redirect_to dashboard_path
      expect(response).to have_http_status(302)
    end
  end
end
