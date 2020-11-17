class ConnectionsController < ApplicationController
    before_action :authenticate_account!
    def index
        @connections = current_account.connections
    end
    
    def create
        @friend_account = Account.find(params[:friend_id])
        @connection = current_account.connections.build(:friend_id => params[:friend_id])
        @inverse_connection = @friend_account.connections.build(:friend_id => current_account.id)
        @friend_request = current_account.friend_requests.find_by(friend_id: params[:friend_id])
        if @friend_request.destroy && @connection.save && @inverse_connection.save
            flash[:notice] = "Added friend."
            redirect_to connections_path
        else
            flash[:notice] = "Unable to add friend."
            redirect_to profile_path(params[:friend_id])
        end
    end
    
end
