require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do

  describe "After logged in, user" do
    login_user
    it "redirects to home page" do
      expect(subject.current_user).to_not eq(nil)
      expect(response).to have_http_status(200)
    end
  end

end
