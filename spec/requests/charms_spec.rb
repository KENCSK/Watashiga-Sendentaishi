require 'rails_helper'

RSpec.describe "Charms", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/charms/index"
      expect(response).to have_http_status(:success)
    end
  end

end
