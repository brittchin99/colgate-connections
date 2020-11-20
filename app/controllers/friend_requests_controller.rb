class FriendRequestsController < ApplicationController
  before_action :authenticate_account!
  def index
    @friend_requests = current_account.friend_requests
  end
  
  def create
    @friend_account = Account.find(params[:friend_id])
    if !current_account.connected_to(@friend_account)
      @friend_requests = @friend_account.friend_requests.build(:friend_id => current_account.id)
      if @friend_requests.save
          # flash[:notice] = "Friend request sent."
      else
          # flash[:alert] = "Unable to add friend."
      end
    else
      flash[:alert] = "You are already friends."
    end
    # redirect_to profile_path(params[:friend_id]) 
    redirect_back(fallback_location: profile_path(params[:friend_id]))
  end
  
  def destroy
    @friend_request = current_account.friend_requests.find_by(friend_id: params[:friend_id])
    if @friend_request == nil
      @friend_account = Account.find_by_id(params[:friend_id])
      @friend_request = @friend_account.friend_requests.find_by(friend_id: current_account.id)
    end
    if @friend_request.destroy
      # flash[:notice] = "Deleted friend request."
    else
      # flash[:alert] = "Unable to delete friend request."
    end
    # redirect_to profile_path(params[:friend_id])
    redirect_back(fallback_location: profile_path(params[:friend_id]))
  end
end
