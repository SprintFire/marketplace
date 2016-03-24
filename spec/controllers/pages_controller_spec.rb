require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  describe "GET #dashboard" do

    it "should get all user shops" do
      user = create(:user, email: "test@test.com")
      sign_in user

      shops = []
      4.times do
        shops << create(:shop, user: user)
      end

      user1 = create(:user, email: "e@e.com")
      4.times do
        create(:shop, user: user1)
      end

      get :dashboard
      expect(assigns(:shops)).to match_array(shops)
    end

  end
end
