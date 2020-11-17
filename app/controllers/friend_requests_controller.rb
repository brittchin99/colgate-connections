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
          flash[:notice] = "Friend request sent."
      else
          flash[:notice] = "Unable to add friend."
      end
    else
      flash[:notice] = "You are already friends."
    end
    redirect_to profile_path(params[:friend_id])
  end
  
  def destroy
    @friend_request = current_account.friend_requests.find_by(friend_id: params[:friend_id])
    if @friend_request.destroy
      flash[:notice] = "Removed friend request."
    else
      flash[:notice] = "Unable to delete friend request."
    end
    redirect_to friend_requests_path
  end
end
