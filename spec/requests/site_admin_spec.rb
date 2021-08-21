require 'rails_helper'

RSpec.describe "SiteAdmins", type: :request do
  describe "GET /home" do
    it "returns http success" do
      get "/site_admin/home"
      expect(response).to have_http_status(:success)
    end
  end

end
