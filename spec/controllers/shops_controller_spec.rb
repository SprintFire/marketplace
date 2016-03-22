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

  describe "GET #edit" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the #edit view" do
      get :edit
      expect(response).to render_template("edit")
    end
  end

  describe "GET #show" do
    it "renders the #show view" do
      get :show
      expect(response).to render_template("show")
    end
  end

  describe "DELETE #destroy" do
    it "deletes the shop" do
      expect{
        delete :destroy, id: @shop
      }.to change (Shop,:count).by(-1)
    end

    it "redirects to shop #index view" do
      delete :destroy, id: @shop
      expect(response).to redirect_to shops_url
    end
  end

end
