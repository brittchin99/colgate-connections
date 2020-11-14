class FriendRequestsController < ApplicationController
  def index
    @friend_requests = current_account.friend_requests
  end
  def create
    @friend_account = Account.find(params[:friend_id])
    @friend_requests = @friend_account.friend_requests.build(:friend_id => current_account.id)
        if @friend_requests.save
            flash[:notice] = "Friend request sent."
        else
            flash[:notice] = "Unable to add friend."
        end
        redirect_to profile_path(params[:friend_id])
  end
end
