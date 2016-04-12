require 'rails_helper'

RSpec.describe "Withdrawals", type: :request do

  describe "GET /api/v1/withdrawals" do
    it "Gets all withdrawals" do
      get '/api/v1/withdrawals'
      expect(JSON.parse(response.body)).to be_an_instance_of(Array)
      expect(response.body).to eq Withdrawal.all.to_json
    end

    it "Returns the information of a withdrawal" do
      get '/api/v1/withdrawals/1'
      expect(JSON.parse(response.body)).to be_an_instance_of(Hash)
    end
  end
end
