require 'rails_helper'

RSpec.describe ProductsController, type: :controller do

  describe "products#index" do
    login_user
    before :each do
      @shop = create(:shop, user: subject.current_user)
      p @shop
    end

    context "logged in" do
      it "goes to all product page" do
        get :index, shop_id: @shop.id
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end
    end

    context "logged out" do
      it "goes to all product page" do
        sign_out :user
        get :index, shop_id: @shop.id
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "products#new" do
    login_user
    before :each do
      @shop = create(:shop, user: subject.current_user)
      p @shop
    end

    context "logged in" do
      it "goes to the creating product page" do
        get :new, shop_id: @shop.id
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end
    end

    context "logged out" do
      it "goes to the creating product page" do
        sign_out :user
        get :new, shop_id: @shop.id
        expect(response).to redirect_to new_user_session_path
        expect(response).to have_http_status(302)
      end
    end
  end

  describe "products#create" do
    login_user
    before :each do
      @shop = create(:shop, user: subject.current_user)
      p @shop
    end

    context "logged in" do
      it "creates a product" do
        product = attributes_for(:product, shop: @shop)
        p product
        post :create, { shop_id: @shop.id, product: product }
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end
    end

    context "logged out" do
      it "creates a product" do
        sign_out :user
        product = attributes_for(:product, shop: @shop)
        p product
        post :create, { shop_id: @shop.id, product: product }
        expect(response).to redirect_to new_user_session_path
        expect(response).to have_http_status(302)
      end
    end
  end

  describe "products#show" do
    login_user
    before :each do
      @shop = create(:shop, user: subject.current_user)
      p @shop
    end

    context "logged in" do
      it "shows the specified product" do
        product = create(:product, shop: @shop)
        p product
        get :show, { shop_id: @shop.id, id: product.id }
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end
    end

    context "logged out" do
      it "shows the specified product" do
        product_by_logged_in_user = create(:product, shop: @shop)
        sign_out :user
        p product_by_logged_in_user
        get :show, { shop_id: @shop.id, id: product_by_logged_in_user.id }
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "products#edit" do
    login_user
    before :each do
      @shop = create(:shop, user: subject.current_user)
      p @shop
    end

    context "logged in" do
      it "goes to the editing product page" do
        product = create(:product, shop: @shop)
        p product
        get :edit, { shop_id: @shop.id, id: product.id }
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end
    end

    context "logged out" do
      it "goes to the editing product page" do
        product_by_logged_in_user = create(:product, shop: @shop)
        sign_out :user
        get :edit, { shop_id: @shop.id, id: product_by_logged_in_user.id }
        expect(response).to redirect_to new_user_session_path
        expect(response).to have_http_status(302)
      end
    end
  end

  describe "products#update" do
    login_user
    before :each do
      @shop = create(:shop, user: subject.current_user)
      p @shop
    end

    context "logged in" do
      it "updates the product information" do
        product = create(:product, shop: @shop)
        put :update, { shop_id: @shop.id, id: product.id, product: product.attributes = { name: 'New name' } }
        product.reload
        p product
        expect(response).to redirect_to shop_product_path
        expect(response).to have_http_status(302)
      end
    end

    context "logged out" do
      it "updates the product information" do
        product_by_logged_in_user = create(:product, shop: @shop)
        sign_out :user
        put :update, { shop_id: @shop.id, id: product_by_logged_in_user.id, product: product_by_logged_in_user.attributes = { name: 'New name' } }
        product_by_logged_in_user.reload
        p product_by_logged_in_user
        expect(response).to redirect_to new_user_session_path
        expect(response).to have_http_status(302)
      end
    end
  end

  describe "products#destroy" do
    login_user
    before :each do
      @shop = create(:shop, user: subject.current_user)
      p @shop
    end

    context "logged in" do
      it "deletes the product" do
        product = create(:product, shop: @shop)
        delete :destroy, { shop_id: @shop.id, id: product.id }
        expect(response).to redirect_to dashboard_path
        expect(response).to have_http_status(302)
      end
    end

    context "logged out" do
      it "deletes the product" do
        product_by_logged_in_user = create(:product, shop: @shop)
        sign_out :user
        delete :destroy, { shop_id: @shop.id, id: product_by_logged_in_user.id }
        expect(response).to redirect_to new_user_session_path
        expect(response).to have_http_status(302)
      end
    end
  end
end
