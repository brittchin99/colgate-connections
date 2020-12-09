class SettingsController < ApplicationController
    before_action :authenticate_account!
    before_action :populate_info!
  
    def show
        @profile = Profile.find(params[:id])
        @setting = @profile.setting
    end
    
    def update
      @profile = Profile.find(params[:id])
      @setting = @profile.setting
      
      if params[:preference]
        if(params[:preference].has_key? :pronouns)
          @setting.preference.pronouns = params[:preference][:pronouns]
        end
        if(params[:preference].has_key? :class_years)
          @setting.preference.class_years = params[:preference][:class_years]
        end
      end
      
      if @setting.update(setting_params)
        flash[:success] = "Account settings updated!"
        redirect_to profile_path(@profile)
      else 
        flash[:alert] = "Failed to update account settings."
        respond_to do |format|
          format.html { render :show }
        end
      end
    end
    
    private
    def setting_params
        params.require(:setting).permit(:dating, :public => [], :notifs => [], preference_attributes: [ :pronouns, :class_years ])
    end 
end
