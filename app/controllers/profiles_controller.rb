class ProfilesController < ApplicationController
  before_action :authenticate_account!
  def index
    @connections = current_account.friendships
  end
  
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
    if params.has_key?("/profiles")
      # THE FORM IN INDEX SHOULD BE FIXED
      p = params["/profiles"]
      @profiles = @profiles.where("first_name LIKE ?", "%#{p["first_name"]}")
                          .where("last_name LIKE ?", "%#{p["last_name"]}")
                          .where("email LIKE ?", "%#{p["email"]}")
                          .where("pronouns LIKE ?", "%#{p["pronouns"]}")
                          .where("class_year LIKE ?", "%#{p["class_year"]}")
                          .where("majors LIKE ?", "%#{p["majors"]}")
                          .where("minors LIKE ?", "%#{p["minors"]}")
                          .where("interests LIKE ?", "%#{p["interests"]}")
    elsif params.has_key?("query")
      @profiles = @profiles.where("first_name LIKE ? 
                                  OR last_name LIKE ?
                                  OR email LIKE ?
                                  OR pronouns LIKE ? 
                                  OR class_year LIKE ?
                                  OR majors LIKE ?
                                  OR minors LIKE ?
                                  OR interests LIKE ?", params["query"], params["query"], params["query"], params["query"], params["query"], params["query"], params["query"], params["query"])
    end
  end
  
  private
  def profile_params
    params.require(:account).permit(:first_name, :last_name, :email, :password, :pronouns, :class_year, :majors => [], :minors => [], :interests => [])
  end
end
