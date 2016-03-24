require 'rails_helper'

RSpec.describe ShopsController, type: :controller do

  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET#show" do
    it "assigns the requested shop to @shop" do
      shop = FactoryGirl.create(:shop)
      get :show, id: shop
      assigns(:shop).should eq(shop)
    end
  end
end
