class AccountsController < ApplicationController
    def index
    end
    
    def new
        @account = Account.new
    end
  
    def create
        puts account_params
        
        @account = Account.new(account_params)

        if @account.save
            flash[:notice] = "Account successfully created. Please check email for verification link."
            redirect_to connections_path and return
        else
            flash[:alert] = "Failed to create account."
            render new_account_path and return
        end
    end
    
    private
    def account_params
        params.require(:account).permit(:first_name, :last_name, :email, :password, :pronouns, :class_year, :majors, :minors, :interests)
    end
end
