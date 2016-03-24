require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "Users controller" do
    login_user
    it "should have a current_user" do
      p subject.current_user
      # note the fact that you should remove the "validate_session" parameter if this was a scaffold-generated controller
      expect(subject.current_user).to_not eq(nil)
    end

    it "goes to edit page" do
      get :edit
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "clicks update button" do
      get :update
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end
end
