class SettingsController < ApplicationController
    before_action :authenticate_account!
    before_action :populate_info!
  
    def show
        @profile = Profile.find(params[:id])
        @setting = @profile.setting
    end
end
