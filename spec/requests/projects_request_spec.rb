require "rails_helper"

RSpec.describe "Projects", type: :request do
  before(:each) do
    @sample_project = FactoryBot.create(:project)
  end

  describe "GET /new" do
    it "returns http success" do
      get new_project_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get project_path(@sample_project)
      expect(response).to have_http_status(:success)
    end
  end

  # TODO:  Add spec for project creation
  # describe "GET /create" do
  #   it "returns http success" do
  #     get "/projects/create"
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  describe "GET /search" do
    it "returns http success" do
      get "/projects/search"
      expect(response).to have_http_status(:success)
    end
  end
end
