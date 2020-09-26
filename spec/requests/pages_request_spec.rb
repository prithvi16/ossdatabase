require 'rails_helper'

RSpec.describe "Pages", type: :request do

  before(:each) do 
    @sample_project = FactoryBot.create(:project)
  end 

  describe "GET home page" do
    it "returns http success" do
      get root_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "sign up page" do
    it "returns http success" do
      get new_user_registration_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "Get password reset page" do
    it "returns http success" do
      get new_user_password_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "Get password confirmation page" do
    it "returns http success" do
      get new_user_confirmation_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "Get browse projects page" do
    it "returns http success" do
      get projects_browse_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "get login page" do
    it "returns http success" do
      get new_user_session_path
      expect(response).to have_http_status(:success)
    end
  end
end
