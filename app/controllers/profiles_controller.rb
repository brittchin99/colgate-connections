class ProfilesController < ApplicationController
  before_action :authenticate_account!

  def show
    @profile = Account.find(params[:id])
  end
  
  
  def edit
    @profile = Account.find(params[:id])
  end

  def update 
    @profile = Account.find(params[:id])
    # @profile.avatar.attach(params[:avatar])
    # @profile.photos.attach(params[:photos])
    if @profile.update_without_password(profile_params)
      flash[:success] = "Profile updated!"
      redirect_to profile_path(@profile)
    else 
      # redirect_to profile_path(@profile)
      flash[:alert] = "failed"
      respond_to do |format|
        format.html { render :edit }
      end
    end
  end 
  
  
  def index
    @profiles = Account.all
    
    if !params.has_key?("reset")
      if p = (params["filter_list"] || session["filter_list"])
        if !p.has_key?("general_search_term")
          @profiles = @profiles.where("first_name LIKE ?", "%#{p["first_name"]}")
                              .where("last_name LIKE ?", "%#{p["last_name"]}")
                              .where("email LIKE ?", "%#{p["email"]}")
                              .where("pronouns LIKE ?", "%#{p["pronouns"]}")
                              .where("cast(class_year as text) LIKE ?", "%#{p["class_year"]}")
                              .where("majors LIKE ?", "%#{p["majors"]}")
                              .where("minors LIKE ?", "%#{p["minors"]}")
                              .where("interests LIKE ?", "%#{p["interests"]}")
        else
          @profiles = @profiles.where("first_name LIKE ? 
                                      OR last_name LIKE ?
                                      OR email LIKE ?
                                      OR pronouns LIKE ? 
                                      OR first_name || ' ' || last_name LIKE ? 
                                      OR cast(class_year as text) LIKE ?", p["general_search_term"], p["general_search_term"], p["general_search_term"], p["general_search_term"], p["general_search_term"], p["general_search_term"])
        end
        session["filter_list"] = params["filter_list"]
      end
    end
  end
  
  private
  def profile_params
    params.require(:account).permit(:first_name, :last_name, :pronouns, :class_year, :majors => [], :minors => [], :interests => [])
  end 
end
