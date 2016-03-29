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

  describe "PUT#update" do

    before(:each) do
      user = create(:user)
      sign_in user
      @shop = create(:shop, :user => user)
      put :update, :id => @shop, :shop => attr
      @shop.reload
    end

    context "with valid attributes" do
      let(:attr) do
        { :name => 'Jane', :email_id => 'me@example.com'}
      end

      it { expect(response).to redirect_to(@shop) }
      it { expect(@shop.name).to eq attr[:name] }
      it { expect(@shop.email_id).to eq attr[:email_id] }
    end

    context "with invalid attributes" do
      let(:attr) do
        { :name => nil, :text => '' }
      end

      it { expect(response).to render_template("edit") }
      it { expect(@shop.name).should_not eq attr[:name] }
    end
  end

  describe "DELETE#destroy" do
    before :each do
      user = create(:user)
      sign_in user
      @shop = create(:shop, :user => user)
    end

    it "deletes the shop" do
      delete :destroy, {id: @shop}
      expect(response).to redirect_to dashboard_path
      expect(response).to have_http_status(302)
    end
  end
end
