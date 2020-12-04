class BlockagesController < ApplicationController
  def index
    @blockages = current_account.profile.blockees
  end
  
  def create
    @blockee = Profile.find(params[:blockee_id])
    @blockage = current_account.profile.blockages.build(:blockee_id => params[:blockee_id])
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
