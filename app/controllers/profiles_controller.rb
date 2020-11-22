class ProfilesController < ApplicationController
  before_action :authenticate_account!
  before_action :populate_info!, except: [:edit, :update]
  
  def show
    @account = Account.find(params[:id])
    if @account.profile.nil?
      redirect_to new_profile_path and return 
    end 
    @profile = @account.profile
  end
  
  
  def edit
    @profile = Profile.find(params[:id])
  end

  def update 
    @profile = Profile.find(params[:id])
    if @profile.update(profile_params)
      flash[:success] = "Profile updated!"
      redirect_to profile_path(@profile)
    else 
      flash[:alert] = "Failed to update profile"
      respond_to do |format|
        format.html { render :edit }
      end
    end
  end 
  
  
  def index
    @profiles = Profile.all
    
    if !params.has_key?("reset")
      if p = (params["filter_list"] || session["filter_list"])
        if !p.has_key?("general_search_term")
          @profiles = @profiles.where("first_name LIKE ?", "%#{p["first_name"]}")
                              .where("last_name LIKE ?", "%#{p["last_name"]}")
                              .where("pronouns LIKE ?", "%#{p["pronouns"]}")
                              .where("cast(class_year as text) LIKE ?", "%#{p["class_year"]}")
                              .where("majors LIKE ?", "%#{p["majors"]}")
                              .where("minors LIKE ?", "%#{p["minors"]}")
                              .where("interests LIKE ?", "%#{p["interests"]}")
        else
          @profiles = @profiles.where("first_name LIKE ? 
                                      OR last_name LIKE ?
                                      OR pronouns LIKE ? 
                                      OR cast(class_year as text) LIKE ?", p["general_search_term"], p["general_search_term"], p["general_search_term"], p["general_search_term"])
        end
        session["filter_list"] = params["filter_list"]
      end
    end
  end
  
  private
  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :pronouns, :class_year, :majors => [], :minors => [], :interests => [])
  end 
end
