require 'rails_helper'

RSpec.describe SearchController, type: :controller do

  describe "search#index" do
    login_user
    before :each do
      @shop = create(:shop, user: subject.current_user)
      p @shop
      @product = create(:product, shop: @shop)
      p @product
      @category = create(:category)
    end

    context "logged in" do
      it "goes to search page without parameters" do
        get :index
        expect(assigns(:shops)).to eq([@shop])
        expect(assigns(:products)).to eq([@product])
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "searches the correct product name" do
        get :index, {keyword_search: @product.name}
        expect(assigns(:shops)).to eq([@shop])
        expect(assigns(:products)).to eq([@product])
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "searches correct category" do
        get :index, {search_category: @product.category_id}
        expect(assigns(:shops)).to eq([@shop])
        expect(assigns(:products)).to eq([@product])
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "searches correct coordinates" do
        get :index, {search: {lat: @shop.latitude, lng: @shop.longitude}}
        expect(assigns(:shops)).to eq([@shop])
        expect(assigns(:products)).to eq([@product])
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "searches correct product name and category" do
        get :index, {keyword_search: @product.name, search_category: @product.category_id}
        expect(assigns(:shops)).to eq([@shop])
        expect(assigns(:products)).to eq([@product])
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "searches correct product name and location" do
        get :index, {keyword_search: @product.name, search: {lat: @shop.latitude, lng: @shop.longitude}}
        expect(assigns(:shops)).to eq([@shop])
        expect(assigns(:products)).to eq([@product])
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "searches correct category and location" do
        get :index, {search_category: @product.category_id, search: {lat: @shop.latitude, lng: @shop.longitude}}
        expect(assigns(:shops)).to eq([@shop])
        expect(assigns(:products)).to eq([@product])
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "searches all correct data" do
        get :index, {keyword_search: @product.name, search: {lat: @shop.latitude, lng: @shop.longitude}, search_category: @product.category_id}
        expect(assigns(:shops)).to eq([@shop])
        expect(assigns(:products)).to eq([@product])
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "searches a false product name" do
        get :index, {keyword_search: Faker::Lorem.characters(10)}
        expect(assigns(:shops)).to eq([])
        expect(assigns(:products)).to eq([])
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "searches a false location" do
        get :index, {search: {lat: Faker::Address.latitude, lng: Faker::Address.longitude}}
        expect(assigns(:shops)).to eq([])
        expect(assigns(:products)).to eq([])
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "searches a false category" do
        get :index, {search_category: @category.id}
        expect(assigns(:shops)).to eq([])
        expect(assigns(:products)).to eq([])
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "searches a correct product name but false location" do
        get :index, {keyword_search: @product.name, search: {lat: Faker::Address.latitude, lng: Faker::Address.longitude}}
        expect(assigns(:shops)).to eq([])
        expect(assigns(:products)).to eq([])
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "searches a correct product name but false category" do
        get :index, {keyword_search: @product.name, search_category: @category.id}
        expect(assigns(:shops)).to eq([])
        expect(assigns(:products)).to eq([])
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "searches a correct location but false product name" do
        get :index, {keyword_search: Faker::Lorem.characters(10), search: {lat: @shop.latitude, lng: @shop.longitude}}
        expect(assigns(:shops)).to eq([])
        expect(assigns(:products)).to eq([])
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "searches a correct location but false category" do
        get :index, {search_category: @category.id, search: {lat: @shop.latitude, lng: @shop.longitude}}
        expect(assigns(:shops)).to eq([])
        expect(assigns(:products)).to eq([])
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "searches a correct category but false product name" do
        get :index, {keyword_search: Faker::Lorem.characters(10), search_category: @product.category_id}
        expect(assigns(:shops)).to eq([])
        expect(assigns(:products)).to eq([])
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "searches a correct category but false location" do
        get :index, {search: {lat: Faker::Address.latitude, lng: Faker::Address.longitude}, search_category: @product.category_id}
        expect(assigns(:shops)).to eq([])
        expect(assigns(:products)).to eq([])
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "searches a false product name and category" do
        get :index, {keyword_search: Faker::Lorem.characters(10), search_category: @category.id}
        expect(assigns(:shops)).to eq([])
        expect(assigns(:products)).to eq([])
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "searches a false product name and location" do
        get :index, {keyword_search: Faker::Lorem.characters(10), search: {lat: Faker::Address.latitude, lng: Faker::Address.longitude}}
        expect(assigns(:shops)).to eq([])
        expect(assigns(:products)).to eq([])
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "searches a false location and category" do
        get :index, {search: {lat: Faker::Address.latitude, lng: Faker::Address.longitude}, search_category: @category.id}
        expect(assigns(:shops)).to eq([])
        expect(assigns(:products)).to eq([])
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "searches a correct product name, but false location and category" do
        get :index, {keyword_search: @product.name, search: {lat: Faker::Address.latitude, lng: Faker::Address.longitude}, search_category: @category.id}
        expect(assigns(:shops)).to eq([])
        expect(assigns(:products)).to eq([])
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "searches a correct location, but false product name and category" do
        get :index, {search: {lat: @shop.latitude, lng: @shop.longitude}, search_category: @category.id, keyword_search: Faker::Lorem.characters(10)}
        expect(assigns(:shops)).to eq([])
        expect(assigns(:products)).to eq([])
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "searches a correct category, but false location and product name" do
        get :index, {search_category: @product.category_id, search: {lat: Faker::Address.latitude, lng: Faker::Address.longitude}, keyword_search: Faker::Lorem.characters(10)}
        expect(assigns(:shops)).to eq([])
        expect(assigns(:products)).to eq([])
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "searches correct product name and location, but false category" do
        get :index, {keyword_search: @product.name, search: {lat: @shop.latitude, lng: @shop.longitude}, search_category: @category.id}
        expect(assigns(:shops)).to eq([])
        expect(assigns(:products)).to eq([])
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "searches correct product name and category, but false location" do
        get :index, {keyword_search: @product.name, search_category: @product.category_id, search: {lat: Faker::Address.latitude, lng: Faker::Address.longitude}, }
        expect(assigns(:shops)).to eq([])
        expect(assigns(:products)).to eq([])
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "searches correct category and location, but false product name" do
        get :index, {search: {lat: @shop.latitude, lng: @shop.longitude}, search_category: @product.category_id, keyword_search: Faker::Lorem.characters(10)}
        expect(assigns(:shops)).to eq([])
        expect(assigns(:products)).to eq([])
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "searches all false data" do
        get :index, {keyword_search: Faker::Lorem.characters(10), search: {lat: Faker::Address.latitude, lng: Faker::Address.longitude}, search_category: @category.id}
        expect(assigns(:shops)).to eq([])
        expect(assigns(:products)).to eq([])
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end
    end # context

    context "logged out" do
      it "goes to search page without parameters" do
        sign_out :user
        get :index
        expect(assigns(:shops)).to eq([@shop])
        expect(assigns(:products)).to eq([@product])
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "searches the correct product name" do
        sign_out :user
        get :index, {keyword_search: @product.name}
        expect(assigns(:shops)).to eq([@shop])
        expect(assigns(:products)).to eq([@product])
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "searches correct category" do
        sign_out :user
        get :index, {search_category: @product.category_id}
        expect(assigns(:shops)).to eq([@shop])
        expect(assigns(:products)).to eq([@product])
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "searches correct coordinates" do
        sign_out :user
        get :index, {search: {lat: @shop.latitude, lng: @shop.longitude}}
        expect(assigns(:shops)).to eq([@shop])
        expect(assigns(:products)).to eq([@product])
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "searches correct product name and category" do
        sign_out :user
        get :index, {keyword_search: @product.name, search_category: @product.category_id}
        expect(assigns(:shops)).to eq([@shop])
        expect(assigns(:products)).to eq([@product])
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "searches correct product name and location" do
        sign_out :user
        get :index, {keyword_search: @product.name, search: {lat: @shop.latitude, lng: @shop.longitude}}
        expect(assigns(:shops)).to eq([@shop])
        expect(assigns(:products)).to eq([@product])
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "searches correct category and location" do
        sign_out :user
        get :index, {search_category: @product.category_id, search: {lat: @shop.latitude, lng: @shop.longitude}}
        expect(assigns(:shops)).to eq([@shop])
        expect(assigns(:products)).to eq([@product])
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "searches all correct data" do
        sign_out :user
        get :index, {keyword_search: @product.name, search: {lat: @shop.latitude, lng: @shop.longitude}, search_category: @product.category_id}
        expect(assigns(:shops)).to eq([@shop])
        expect(assigns(:products)).to eq([@product])
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "searches a false product name" do
        sign_out :user
        get :index, {keyword_search: Faker::Lorem.characters(10)}
        expect(assigns(:shops)).to eq([])
        expect(assigns(:products)).to eq([])
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "searches a false location" do
        sign_out :user
        get :index, {search: {lat: Faker::Address.latitude, lng: Faker::Address.longitude}}
        expect(assigns(:shops)).to eq([])
        expect(assigns(:products)).to eq([])
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "searches a false category" do
        sign_out :user
        get :index, {search_category: @category.id}
        expect(assigns(:shops)).to eq([])
        expect(assigns(:products)).to eq([])
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "searches a correct product name but false location" do
        sign_out :user
        get :index, {keyword_search: @product.name, search: {lat: Faker::Address.latitude, lng: Faker::Address.longitude}}
        expect(assigns(:shops)).to eq([])
        expect(assigns(:products)).to eq([])
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "searches a correct product name but false category" do
        sign_out :user
        get :index, {keyword_search: @product.name, search_category: @category.id}
        expect(assigns(:shops)).to eq([])
        expect(assigns(:products)).to eq([])
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "searches a correct location but false product name" do
        sign_out :user
        get :index, {keyword_search: Faker::Lorem.characters(10), search: {lat: @shop.latitude, lng: @shop.longitude}}
        expect(assigns(:shops)).to eq([])
        expect(assigns(:products)).to eq([])
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "searches a correct location but false category" do
        sign_out :user
        get :index, {search_category: @category.id, search: {lat: @shop.latitude, lng: @shop.longitude}}
        expect(assigns(:shops)).to eq([])
        expect(assigns(:products)).to eq([])
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "searches a correct category but false product name" do
        sign_out :user
        get :index, {keyword_search: Faker::Lorem.characters(10), search_category: @product.category_id}
        expect(assigns(:shops)).to eq([])
        expect(assigns(:products)).to eq([])
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "searches a correct category but false location" do
        sign_out :user
        get :index, {search: {lat: Faker::Address.latitude, lng: Faker::Address.longitude}, search_category: @product.category_id}
        expect(assigns(:shops)).to eq([])
        expect(assigns(:products)).to eq([])
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "searches a false product name and category" do
        sign_out :user
        get :index, {keyword_search: Faker::Lorem.characters(10), search_category: @category.id}
        expect(assigns(:shops)).to eq([])
        expect(assigns(:products)).to eq([])
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "searches a false product name and location" do
        sign_out :user
        get :index, {keyword_search: Faker::Lorem.characters(10), search: {lat: Faker::Address.latitude, lng: Faker::Address.longitude}}
        expect(assigns(:shops)).to eq([])
        expect(assigns(:products)).to eq([])
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "searches a false location and category" do
        sign_out :user
        get :index, {search: {lat: Faker::Address.latitude, lng: Faker::Address.longitude}, search_category: @category.id}
        expect(assigns(:shops)).to eq([])
        expect(assigns(:products)).to eq([])
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "searches a correct product name, but false location and category" do
        sign_out :user
        get :index, {keyword_search: @product.name, search: {lat: Faker::Address.latitude, lng: Faker::Address.longitude}, search_category: @category.id}
        expect(assigns(:shops)).to eq([])
        expect(assigns(:products)).to eq([])
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "searches a correct location, but false product name and category" do
        sign_out :user
        get :index, {search: {lat: @shop.latitude, lng: @shop.longitude}, search_category: @category.id, keyword_search: Faker::Lorem.characters(10)}
        expect(assigns(:shops)).to eq([])
        expect(assigns(:products)).to eq([])
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "searches a correct category, but false location and product name" do
        sign_out :user
        get :index, {search_category: @product.category_id, search: {lat: Faker::Address.latitude, lng: Faker::Address.longitude}, keyword_search: Faker::Lorem.characters(10)}
        expect(assigns(:shops)).to eq([])
        expect(assigns(:products)).to eq([])
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "searches correct product name and location, but false category" do
        sign_out :user
        get :index, {keyword_search: @product.name, search: {lat: @shop.latitude, lng: @shop.longitude}, search_category: @category.id}
        expect(assigns(:shops)).to eq([])
        expect(assigns(:products)).to eq([])
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "searches correct product name and category, but false location" do
        sign_out :user
        get :index, {keyword_search: @product.name, search_category: @product.category_id, search: {lat: Faker::Address.latitude, lng: Faker::Address.longitude}, }
        expect(assigns(:shops)).to eq([])
        expect(assigns(:products)).to eq([])
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "searches correct category and location, but false product name" do
        sign_out :user
        get :index, {search: {lat: @shop.latitude, lng: @shop.longitude}, search_category: @product.category_id, keyword_search: Faker::Lorem.characters(10)}
        expect(assigns(:shops)).to eq([])
        expect(assigns(:products)).to eq([])
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "searches all false data" do
        sign_out :user
        get :index, {keyword_search: Faker::Lorem.characters(10), search: {lat: Faker::Address.latitude, lng: Faker::Address.longitude}, search_category: @category.id}
        expect(assigns(:shops)).to eq([])
        expect(assigns(:products)).to eq([])
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end
    end # context
  end # describe
end
