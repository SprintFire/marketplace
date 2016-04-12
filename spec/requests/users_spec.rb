require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /api/v1/users" do
    it "gets all users" do
      get '/api/v1/users'
      expect(JSON.parse(response.body)).to be_an_instance_of(Array)
      expect(response.body).to eq User.all.to_json
    end
  end
end
