require 'rails_helper'

RSpec.describe ErrorsController, type: :controller do

  describe "GET#not_found" do
    it "responds successfully with an HTTP 404 status code" do
      get :not_found
      expect(response.status).to eq(404)
    end

    it "renders the not_found page" do
      get :not_found
      expect(response).to render_template("not_found")
    end

    it "access a not_found page and then return the template" do
      get :not_found, { id: 'not_existing_page_321' }
      expect(response).to render_template("not_found")
      expect(response.status).to eq(404)
    end
  end

  describe "GET#internal_server_error" do
    it "responds successfully with an HTTP 500 status code" do
      get :internal_server_error
      expect(response.status).to eq(500)
    end

    it "renders the internal_server_error page" do
      get :internal_server_error
      expect(response).to render_template("internal_server_error")
    end

    it "access a internal_server_error page and then return the template" do
      get :internal_server_error, { id: 'not_existing_page_101' }
      expect(response).to render_template("internal_server_error")
      expect(response.status).to eq(500)
    end

  end
end
