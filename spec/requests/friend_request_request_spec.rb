require 'rails_helper'

RSpec.describe "FriendRequests", type: :request do

  describe "GET /create" do
    it "returns http success" do
      get "/friend_request/create"
      expect(response).to have_http_status(:success)
    end
  end

end
