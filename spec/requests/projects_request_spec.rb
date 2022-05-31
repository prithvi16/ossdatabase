require "rails_helper"

RSpec.describe "Projects", type: :request do
  before(:each) do
    @sample_project = FactoryBot.create(:project)
  end

  describe "GET /new" do
    it "returns http success" do
      get new_submission_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get project_path(@sample_project)
      expect(response).to have_http_status(:success)
    end
  end
end
