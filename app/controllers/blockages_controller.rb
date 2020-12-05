class BlockagesController < ApplicationController
  before_action :authenticate_account!
  before_action :populate_info!
    
  def index
    @blockages = current_account.profile.blockees
  end
  
  def create
    @blockee = Profile.find(params[:blockee_id])
    @blockage = current_account.profile.blockages.build(:blockee_id => params[:blockee_id])
    @connection1 = current_account.profile.connections.find_by(friend_id: params[:blockee_id])
    @friend_request1 = current_account.profile.friend_requests.find_by(friend_id: params[:friend_id])
    @friend_request2 = @blockee.friend_requests.find_by(friend_id: current_account.profile.id)
    if @connection1
      @connection2 = @blockee.connections.find_by(friend_id: current_account.profile.id)
      @connection1.destroy
      @connection2.destroy
    elsif @friend_request1
      @friend_request1.destroy
    elsif @friend_request2
      @friend_request2.destroy
    end
    if @blockage.save
      # flash[:notice] = "User blocked."
    else
      # flash[:alert] = "Unable to block user."
    end
    redirect_back(fallback_location: profile_path(params[:blockee_id]))
  end
  
  def destroy
    @blockage = current_account.profile.blockages.find_by(blockee_id: params[:blockee_id])
    if @blockage == nil
      @blockee = Profile.find_by_id(params[:blockee_id])
      @blockage = @blockee.blockages.find_by(blockee_id: current_account.id)
    end
    if @blockage.destroy
      # flash[:notice] = "User unblocked."
    else
      # flash[:alert] = "Unable to unblock user."
    end
    redirect_back(fallback_location: profile_path(params[:blockee_id]))
  end
end
