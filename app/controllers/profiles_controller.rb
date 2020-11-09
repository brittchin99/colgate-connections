class ProfilesController < ApplicationController
  def index
    @connections = current_account.friendships
  end
  
  def show
    @profile = Account.find(params[:id])
  end
end
