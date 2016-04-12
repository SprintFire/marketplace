require 'rails_helper'

RSpec.describe "Withdrawals", type: :request do

  describe "GET /api/v1/withdrawals" do
    it "Gets all withdrawals" do
      get '/api/v1/withdrawals'
      expect(JSON.parse(response.body)).to be_an_instance_of(Array)
      expect(response.body).to eq Withdrawal.all.to_json
    end

    it "GET /api/v1/withdrawals/:id" do
      # get '/api/v1/withdrawals/1'
      # expect(JSON.parse(response.body)).to be_an_instance_of(Hash)
      # expect(response.body).to eq Withdrawal.where(id: 1).to_json
      withdrawal = create(:withdrawal)
      get "/api/v1/withdrawals/#{withdrawal.id}"
      expect(response.body).to eq withdrawal.to_json
    end
  end
end
