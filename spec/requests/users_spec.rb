require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /api/v1/users" do
    it "gets all users" do
      get '/api/v1/users'
      expect(JSON.parse(response.body)).to be_an_instance_of(Array)
      expect(response.body).to eq User.all.to_json
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /api/v1/users/auth/sign_up" do
    it 'registers a user' do
      params = {email: "#{Faker::Internet.email}", first_name: "#{Faker::Name.first_name}", last_name: "#{Faker::Name.last_name}", password: "#{Faker::Internet.password(8)}"}
      post '/api/v1/users/auth/sign_up', params.to_json, {'ACCEPT': "application/json", 'CONTENT_TYPE': 'multipart/form-data'}
      expect(response).to have_http_status(400)
    end
  end

  describe "POST /api/v1/users/auth/sign_up" do
    it 'logs in a user' do
      user = create(:user)
      params = {email: "#{user.email}", password: "#{user.password}"}
      post '/api/v1/users/auth/sign_in', params.to_json, {'ACCEPT': "application/json", 'CONTENT_TYPE': 'multipart/form-data'}
      expect(response).to have_http_status(400)
    end
  end

  describe "GET /api/v1/users/:id" do
    it 'gets information of a user' do
      user = create(:user)
      get "/api/v1/users/#{user.id}"
      expect(response.body).to eq user.to_json
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /api/v1/users/:id/cards" do
    it 'gets all cards of a user' do
      user = create(:user)
      get "/api/v1/users/#{user.id}/cards"
      expect(response.body).to eq Card.where(user_id: user.id).all.to_json
      expect(JSON.parse(response.body)).to be_an_instance_of(Array)
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /api/v1/users/:id/purchases" do
    it 'gets all purchases by a user' do
      user = create(:user)
      get "/api/v1/users/#{user.id}/purchases"
      expect(response.body).to eq Purchase.where(user_id: user.id).all.to_json
      expect(JSON.parse(response.body)).to be_an_instance_of(Array)
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /api/v1/users/:id/purchases" do

  end
end
