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
      shop = create(:shop)
      get :show, id: shop
      assigns(:shop).should eq(shop)
    end
  end

  describe "GET#new" do
    context "when initialized" do
      let(:shop) { Shop.new }

      it "is a new shop" do
        user = create(:user)
        sign_in user
        expect(shop).to be_a_new(Shop)
      end
    end
  end
  
  describe "POST#create" do
    context "with valid attributes" do
      it "creates a new shop" do
        user = create(:user)
        sign_in user
        shop_attributes = attributes_for(:shop)
        expect{
          post :create, {shop: shop_attributes}
        }.to change(Shop,:count).by(1)
      end
    end
  end

end
