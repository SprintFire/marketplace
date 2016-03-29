require 'rails_helper'

RSpec.describe CheckoutsController, type: :controller do
  describe "GET#new" do
    before :each do
      user = create(:user)
      sign_in user
      @shop = create(:shop, :user => user)
    end

    it "goes to the checkout page" do
      product = create(:product, shop: @shop)
      get :new, id: product.id
      cards = create(:card, :user => subject.current_user)
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end
end
