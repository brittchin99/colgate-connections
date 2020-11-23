require 'rails_helper'

RSpec.describe HomesController, type: :controller do
    context "root route" do
        it "routes to homes#index" do
            expect(:get => '/').to route_to(:controller => 'homes', :action => 'index')
        end
    end

    context "index" do
        it "routes correctly" do
            get :index
            expect(response.status).to eq(200)
        end

        # it "redirects to account profile if logged in" do
        #     get :index
        #     expect(response).to redirect_to(profile_path(current_account)) if account_signed_in?
        # end
    end

   
end
