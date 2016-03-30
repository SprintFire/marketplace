require 'rails_helper'

RSpec.describe SearchController, type: :controller do

  describe "search#index" do
    login_user
    before :each do
      @shop = create(:shop, user: subject.current_user)
      p @shop
      product = create(:product, shop: @shop)
    end

    context "logged in" do
      it "goes to search page without parameters" do
        get :index
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
    end
  end

end
