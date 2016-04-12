require 'rails_helper'

RSpec.describe "Cards", type: :request do
  describe "GET /api/v1/cards" do
    it "Gets all cards" do
      get '/api/v1/cards'
      expect(JSON.parse(response.body)).to be_an_instance_of(Array)
      expect(response.body).to eq Card.all.to_json
      expect(response).to have_http_status(200)
    end

    it "GET /api/v1/cards/:id" do
      card = create(:card)
      get "/api/v1/cards/#{card.id}"
      expect(response.body).to eq card.to_json
      expect(response).to have_http_status(200)
    end
  end
end
