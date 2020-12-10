class MessagesController < ApplicationController
    before_action :authenticate_account!
    before_action :populate_info!
    before_action do
        @conversation = Conversation.find(params[:conversation_id])
    end
    
    def index
        @messages = @conversation.messages
        if @messages.length > 10
            @over_ten = true
            @messages = @messages[-10..-1]
        end
  
        if params[:m]
            @over_ten = false
            @messages = @conversation.messages
        end
        
        if @messages.last
            if @messages.last.profile_id != current_account.profile.id
                @messages.last.read = true;
            end
        end
        
        if @conversation.sender == current_account.profile
            @partner = @conversation.receiver
        else
            @partner = @conversation.sender
        end
        if current_account.profile.connected_to(@partner)
            @message = @conversation.messages.new
        end
    end
    
    
    def new
        if @conversation.sender == current_account.profile
            @partner = @conversation.receiver
        else
            @partner = @conversation.sender
        end
        if current_account.profile.connected_to(@partner)
            @message = @conversation.messages.new
            @message.read = false
        end
    end
    
    def create
        if @conversation.sender == current_account.profile
            @partner = @conversation.receiver
        else
            @partner = @conversation.sender
        end
        if current_account.profile.connected_to(@partner)
            @message = @conversation.messages.new(message_params)
            @message.read = false
            if @message.save
                redirect_to conversation_messages_path(@conversation)
            end
        else
            flash[:alert] = "Unable to message user"
            redirect_to conversation_messages_path(@conversation)
        end
    end
    
    private
    def message_params
        params.require(:message).permit(:body, :profile_id)
    end
end