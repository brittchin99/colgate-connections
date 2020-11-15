class ConnectionsController < ApplicationController
    before_action :authenticate_account!
    def index
        @connections = current_account.friendships
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
    
end
