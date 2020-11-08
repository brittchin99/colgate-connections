class ConnectionsController < ApplicationController
    def index
    end
    
    def create
        if params.include?(:friend_id)
            @new_connections = Connection.create_reciprocal_for_ids(current_account.id, params[:friend_id])
        else
            params[:account][:friend_ids].each do |f_id|
                @new_connections = Connection.create_reciprocal_for_ids(current_account.id, f_id)
            end
        end
        redirect_to accounts_path
    end
    
    def destroy
        Connection.destroy_reciprocal_for_ids(current_account.id,params[:friend_id])
        redirect_to(request.referer)
    end
end
