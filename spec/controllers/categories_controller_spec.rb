require 'rails_helper'

RSpec.describe CategoryController, type: :controller do

  describe "GET #show" do

    it "should get the specified category in the params" do
      category = create(:category, title: "Test")
      get :show, id: category.id
      expect(assigns(:category)).to eq(category)
    end

    it "should get all products with that category" do
      category = create(:category, title: "Test")
      shop = create(:shop)

      products = []
      10.times do
        products << create(:product, shop: shop, category: category)
      end

      get :show, id: category.id
      expect(assigns(:products)).to eq(products)
    end
  end
end
