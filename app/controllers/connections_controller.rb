class ConnectionsController < ApplicationController
    before_action :authenticate_account!
    def index
        @friend_requests = current_account.friend_requests
        @connections = current_account.connections.joins(:friend).group("first_name")
        
        @sort_key = "Name"
        
        if params.has_key?("filter_list")
            p = params["filter_list"] 
            
            
            if p.has_key?("general_search_term")
               @connections = @connections.joins(:friend).where("first_name LIKE ? 
                                      OR last_name LIKE ?
                                      OR email LIKE ?
                                      OR pronouns LIKE ? 
                                      OR first_name || ' ' || last_name LIKE ? 
                                      OR cast(class_year as text) LIKE ?", p["general_search_term"], p["general_search_term"], p["general_search_term"], p["general_search_term"], p["general_search_term"], p["general_search_term"])
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
                    @connections = @connections.joins(:friend).group("first_name")
                end
            end
            
            
        end
    end
    
    def create
        @friend_account = Account.find(params[:friend_id])
        @connection = current_account.connections.build(:friend_id => params[:friend_id])
        @inverse_connection = @friend_account.connections.build(:friend_id => current_account.id)
        @friend_request = current_account.friend_requests.find_by(friend_id: params[:friend_id])
        if @friend_request.destroy && @connection.save && @inverse_connection.save
            flash[:notice] = "Added friend."
        else
            flash[:alert] = "Unable to add friend."
        end
        redirect_to profile_path(params[:friend_id]) 

    end
    
end
