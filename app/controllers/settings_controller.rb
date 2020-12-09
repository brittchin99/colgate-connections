class SettingsController < ApplicationController
    before_action :authenticate_account!
    before_action :populate_info!
    accepts_nested_attributes_for :preferences
  
    def show
        @profile = Profile.find(params[:id])
        @setting = @profile.setting
    end
    
    def update
        puts setting_params
    end
    
    private
    def setting_params
        params.require(:setting).permit(:dating, :preferences => [], :public => [], :notifs => [])
    end 
end
