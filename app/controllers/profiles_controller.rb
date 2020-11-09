class ProfilesController < ApplicationController
  before_action :authenticate_account!
  def index
    @connections = current_account.friendships
  end
  
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

  def index
    @connections = current_account.friendships
    
    @profiles = Account.all
    
    if !params.has_key?("reset")
      if p = (params["filter_list"] || session["filter_list"])
        if !p.has_key?("general_search_term")
          @profiles = @profiles.where("first_name LIKE ?", "%#{p["first_name"]}")
                              .where("last_name LIKE ?", "%#{p["last_name"]}")
                              .where("email LIKE ?", "%#{p["email"]}")
                              .where("pronouns LIKE ?", "%#{p["pronouns"]}")
                              .where("class_year LIKE ?", "%#{p["class_year"]}")
                              .where("majors LIKE ?", "%#{p["majors"]}")
                              .where("minors LIKE ?", "%#{p["minors"]}")
                              .where("interests LIKE ?", "%#{p["interests"]}")
        else
          @profiles = @profiles.where("first_name LIKE ? 
                                      OR last_name LIKE ?
                                      OR email LIKE ?
                                      OR pronouns LIKE ? 
                                      OR class_year LIKE ?", p["general_search_term"], p["general_search_term"], p["general_search_term"], p["general_search_term"], p["general_search_term"])
        end
        session["filter_list"] = params["filter_list"]
      end
    end
    
  end
 
end
