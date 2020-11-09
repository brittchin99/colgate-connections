class ProfilesController < ApplicationController
  def show
    @profile = Account.find(params[:id])
  end
  
  def index
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
end
