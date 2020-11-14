class ConnectionsController < ApplicationController
    before_action :authenticate_account!
    def index
        @connections = current_account.friendships.joins(:friend).group("first_name")
        
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
        @connection = current_account.connections.build(:friend_id => params[:friend_id])
        if @connection.save
            flash[:notice] = "Added friend."
            redirect_to connections_path
        else
            flash[:notice] = "Unable to add friend."
            redirect_to profile_path(params[:friend_id])
        end
    end
    
    def destroy
        Connection.destroy_reciprocal_for_ids(current_account.id,params[:friend_id])
        redirect_to(request.referer)
    end
end
