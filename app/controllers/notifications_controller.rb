class NotificationsController < ApplicationController
    before_action :authenticate_account!
    before_action :populate_info!
  
    def index
        @notifications = current_account.profile.notifications.order("created_at DESC")
        @notifications.each do |n|
            n.update_attributes(:read => true)
        end
    end
end
