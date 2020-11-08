require 'rails_helper'

RSpec.describe "Accounts", type: :request do

  describe "GET /new" do
    it "returns http success" do
      get "/accounts/new"
      expect(response).to have_http_status(:success)
    end
  end

end
