class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    helper_method :resource_name, :resource, :devise_mapping, :resource_class
    def resource_name
      :account
    end
     
    def resource
      @resource ||= Account.new
    end
    def resource_class
      Account
    end
     
    def devise_mapping
      @devise_mapping ||= Devise.mappings[:account]
    end
    
    def after_sign_in_path_for(resource)
      if current_account.profile.first_name
        return profile_path(current_account)
      else
        return edit_profile_path(current_account)
      end
    end
    
    protected
    def authenticate_account!
      if account_signed_in?
        super
      else
        if request.path!=homes_path && request.path!=new_account_session_path && request.path!=new_account_registration_path
          redirect_to new_account_session_path
        end
      end
    end
    
    def populate_info!
      if account_signed_in? && current_account.profile.first_name.nil?
        redirect_to edit_profile_path(current_account)
      end
    end
end
