require 'rails_helper'

RSpec.describe SearchController, type: :controller do
   describe "GET #index" do

    it "responds successfully without parameters passed in" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

  end
end
