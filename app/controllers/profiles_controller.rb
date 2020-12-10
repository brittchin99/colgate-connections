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
    @profiles = Profile.where("id NOT LIKE ?", current_account.profile.id)
    @profiles = @profiles.where('id NOT IN (?)', current_account.profile.blockees.map(&:id).join(','))
    @profiles = @profiles.where('id NOT IN (?)', Blockage.where('blockee_id LIKE ?', current_account.profile.id).map(&:profile_id).join(','))

    if !session.has_key?(:filter_list)
      session[:filter_list] = {}
    end
  
    if !params.has_key?("reset")
      if p = (params["filter_list"] || session["filter_list"])
        if !p.has_key?("general_search_term")
          @profiles = @profiles.where("first_name LIKE ?", "%#{p["first_name"]}")
                              .where("last_name LIKE ?", "%#{p["last_name"]}")
                              .where("pronouns LIKE ?", "%#{p["pronouns"]}")
                              .where("cast(class_year as text) LIKE ?", "%#{p["class_year"]}")
          for major in Profile.toList(p["majors"].to_s)
            @profiles = @profiles.where("majors LIKE ?", "%#{major}%")
          end
          
          for minor in Profile.toList(p["minors"].to_s)
            @profiles = @profiles.where("minors LIKE ?", "%#{minor}%")
          end
          
          for interest in Profile.toList(p["interests"].to_s)
            @profiles = @profiles.where("interests LIKE ?", "%#{interest}%")
          end
          
        else
          @profiles = @profiles.where("first_name LIKE ? 
                                      OR last_name LIKE ?
                                      OR pronouns LIKE ? 
                                      OR first_name || ' ' || last_name LIKE ? 
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
