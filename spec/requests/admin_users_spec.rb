require 'rails_helper'

RSpec.describe "AdminUsers", type: :request do
  describe "GET /api/v1/admin_users" do
    it "gets all Admin Users" do
      get '/api/v1/admin_users'
      expect(JSON.parse(response.body)).to be_an_instance_of(Array)
      expect(response.body).to eq AdminUser.all.to_json
    end
  end
end
