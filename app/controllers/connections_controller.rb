class ConnectionsController < ApplicationController
    def index
        @accounts = Account.all
    end
    
    def create
        @connection = current_account.connections.build(:friend_id => params[:friend_id])
        if @connection.save
            flash[:notice] = "Added friend."
            redirect_to root_url
        else
            flash[:notice] = "Unable to add friend."
            redirect_to root_url
        end
    end
    
    def destroy
        Connection.destroy_reciprocal_for_ids(current_account.id,params[:friend_id])
        redirect_to(request.referer)
    end
end
