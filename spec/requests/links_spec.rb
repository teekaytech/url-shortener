require 'rails_helper'

RSpec.describe "Links", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/links/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/links/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/links/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/links/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
