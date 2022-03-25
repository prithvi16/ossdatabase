require 'rails_helper'

RSpec.describe "Submissions", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/submissions/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/submissions/create"
      expect(response).to have_http_status(:success)
    end
  end

end
