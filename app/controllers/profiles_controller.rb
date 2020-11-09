class ProfilesController < ApplicationController
  def show
    @profile = Account.find(params[:id])
  end
  
  def edit
      @profile = Account.find(params[:id])
  end

  def update 
    @profile = Account.find(params[:id])
    if @profile.update(profile_params)
      redirect_to profile_path(@profile)
    else 
      render json: @profile.errors.full_messages, status: 422
    end 
  end 
    
  private
  def profile_params
      params.require(:profile).permit(:first_name, :last_name, :email, :password, :pronouns, :class_year, :majors => [], :minors => [], :interests => [])
  end
end
