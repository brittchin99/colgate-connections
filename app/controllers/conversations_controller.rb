class ConversationsController < ApplicationController
    before_action :authenticate_account!
    before_action :populate_info!

    def index
        @conversations = Conversation.order('updated_at DESC')

    end
    
    def new
        @connections = current_account.profile.connections
    end


    def create
        @partner = Profile.find_by_id(params[:receiver_id])
        if current_account.profile.connected_to(@partner)
            if Conversation.between(params[:sender_id],params[:receiver_id]).present?
                @conversation = Conversation.between(params[:sender_id], params[:receiver_id]).first
            else
                @conversation = Conversation.create!(conversation_params)
            end
            redirect_to conversation_messages_path(@conversation)
        else
            flash[:alert] = "Unable to message user"
            redirect_to conversations_path
        end
    end

    private
    def conversation_params
        params.permit(:sender_id, :receiver_id)
    end
end