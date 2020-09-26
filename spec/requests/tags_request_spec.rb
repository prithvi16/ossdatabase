require 'rails_helper'

RSpec.describe "Tags", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/tags/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/tags/show"
      expect(response).to have_http_status(:success)
    end
  end

end
