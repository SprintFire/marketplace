require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET user#edit" do
    it "goes to edit page" do
      get :edit
      expect(response).to success
      expect(response).to have_http_status(200)
    end
  end
end
