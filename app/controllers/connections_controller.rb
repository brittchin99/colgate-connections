class ConnectionsController < ApplicationController
    before_action :authenticate_account!
    before_action :populate_info!
    
    def index
        @friend_requests = current_account.profile.friend_requests
        @connections = current_account.profile.connections.joins(:friend)
        
        @sort_key = "Name"
        if !params.has_key?("reset")
            if params.has_key?("filter_list")
                p = params["filter_list"] 
                
                
                if p.has_key?("general_search_term")
                   @connections = @connections.joins(:friend).where("first_name LIKE ? 
                                          OR last_name LIKE ?
                                          OR pronouns LIKE ? 
                                          OR first_name || ' ' || last_name LIKE ? 
                                          OR cast(class_year as text) LIKE ?", p["general_search_term"], p["general_search_term"], p["general_search_term"], p["general_search_term"], p["general_search_term"])
                end
                
                
                if p.has_key?("sort_by")
                    sort_key = p["sort_by"]
                    if sort_key == "Date Connected: Latest"
                        @connections = @connections.order("created_at DESC")
                        @sort_key = "Date Connected: Latest"
                    elsif sort_key == "Date Connected: Earliest"
                        @connections = @connections.order("created_at")
                        @sort_key = "Date Connected: Earliest"
                    elsif sort_key == "Name"
                        @connections = @connections.joins(:friend).order("first_name")
                    end
                end
                
                
            end
        end
    end
    
    def create
        @friend_account = Profile.find(params[:friend_id])
        @connection = current_account.profile.connections.build(:friend_id => params[:friend_id])
        @inverse_connection = @friend_account.connections.build(:friend_id => current_account.id)
        @friend_request = current_account.profile.friend_requests.find_by(friend_id: params[:friend_id])
        if @friend_request.destroy && @connection.save && @inverse_connection.save
            # flash[:notice] = "Added connection."
        else
            # flash[:alert] = "Unable to add connection."
        end
        # redirect_to profile_path(params[:friend_id]) 
        redirect_back(fallback_location: profile_path(params[:friend_id]))

    end
    
    def destroy
        @connection1 = current_account.profile.connections.find_by(friend_id: params[:friend_id])
        @friend_account = Profile.find_by_id(params[:friend_id])
        if @friend_account
            @connection2 = @friend_account.connections.find_by(friend_id: current_account.id)
            if @connection1.destroy && @connection2.destroy
            #   flash[:notice] = "Removed connection."
            else
            #   flash[:alert] = "Unable to delete friend request."
            end
        else
            # flash[:alert] = "Friend not found."
        end
        # redirect_to profile_path(params[:friend_id])
        redirect_back(fallback_location: profile_path(params[:friend_id]))
    end
    
end
