require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  describe "Products controller" do
    it "goes to all product page" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end
end
