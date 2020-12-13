class ProfilesController < ApplicationController
  before_action :authenticate_account!
  before_action :populate_info!, except: [:edit, :update]
  
  def show
    @account = Account.find(params[:id])
    @profile = @account.profile
  end
  
  
  def edit
    @profile = Profile.find(params[:id])
  end

  def update 
    @profile = Profile.find(params[:id])
    attributes = {:majors => @profile.majors, :minors => @profile.minors, :interests => @profile.interests}
    unless params[:profile].nil?
      if(!params[:profile][:avatar].nil?)
        @profile.avatar.purge
        @profile.avatar.attach(params[:profile][:avatar])
      end 
  
      if (!params[:profile][:photos].nil?)
        @profile.photos.attach(params[:profile][:photos])
      end 
      if @profile.update(profile_params)
        flash[:success] = "Profile updated!"
        [:majors, :minors, :interests].each do |field|
          if (!params[:profile][field].blank? && params[:profile][field].to_s!=attributes[field].to_s)
            current_account.profile.friends.each do |c|
              c.notifications.create(:updater_id => current_account.profile.id, :category => field.to_s, :read => false)
            end
          end
        end
        redirect_to profile_path(@profile)
      else 
        flash[:alert] = "Failed to update profile"
        respond_to do |format|
          format.html { render :edit }
        end
      end
    else
      redirect_to profile_path(@profile)
    end
  end
  
  
  def index
    @profiles = current_account.profile.get_accessible_profiles
    
    if !session.has_key?(:filter_list)
      session[:filter_list] = {}
    end
  
    if !params.has_key?("reset")
      if p = (params["filter_list"] || session["filter_list"])
        if !p.has_key?("general_search_term")
          @profiles = @profiles.where("LOWER(first_name) LIKE LOWER(?)", "%#{p["first_name"]}")
                              .where("LOWER(last_name) LIKE LOWER(?)", "%#{p["last_name"]}")
                              .where("LOWER(pronouns) LIKE LOWER(?)", "%#{p["pronouns"]}")
                              .where("cast(class_year as text) LIKE ?", "%#{p["class_year"]}")
          for major in Profile.toList(p["majors"].to_s)
            @profiles = @profiles.where("LOWER(majors) LIKE LOWER(?)", "%#{major}%")
          end
          
          for minor in Profile.toList(p["minors"].to_s)
            @profiles = @profiles.where("LOWER(minors) LIKE LOWER(?)", "%#{minor}%")
          end
          
          for interest in Profile.toList(p["interests"].to_s)
            @profiles = @profiles.where("LOWER(interests) LIKE LOWER(?)", "%#{interest}%")
          end
          
        else
          @profiles = @profiles.where("LOWER(first_name) LIKE LOWER(?) 
                                      OR LOWER(last_name) LIKE LOWER(?)
                                      OR LOWER(pronouns) LIKE LOWER(?) 
                                      OR LOWER(first_name || ' ' || last_name) LIKE LOWER(?) 
                                      OR cast(class_year as text) LIKE ?", p["general_search_term"], p["general_search_term"], p["general_search_term"], p["general_search_term"], p["general_search_term"])
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
