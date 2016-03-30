require 'rails_helper'

RSpec.describe SearchController, type: :controller do

  describe "search#index" do
    login_user
    before :each do
      @shop = create(:shop, user: subject.current_user)
      p @shop
      @product = create(:product, shop: @shop)
      p @product
    end

    context "logged in" do
      it "goes to search page without parameters" do
        get :index
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "searches the name that been created" do
        get :index, {keyword_search: @product.name}
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "searches certain category" do
        get :index, {search_category: @product.category_id}
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "searches certain coordinates" do
        get :index, {lat: @shop.latitude, lng: @shop.longitude}
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "searches the name that been created" do
        get :index, {keyword_search: "12345"}
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end
    end

    context "logged out" do
      it "goes to search page without parameters" do
        sign_out :user
        get :index
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "searches the name that been created" do
        sign_out :user
        get :index, {keyword_search: @product.name}
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "searches certain category" do
        sign_out :user
        get :index, {search_category: @product.category_id}
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "searches certain coordinates" do
        sign_out :user
        get :index, {lat: @shop.latitude, lng: @shop.longitude}
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "searches the name that been created" do
        sign_out :user
        get :index, {keyword_search: "12345"}
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end
    end # context
  end # describe
end
