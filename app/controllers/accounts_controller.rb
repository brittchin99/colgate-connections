class AccountsController < ApplicationController
    def index
    end
    
    def new
        @account = Account.new
    end
  
    def create
        # @account = Account.new(account_params)
        puts account_params
        flash[:notice] = "Test succeeded"
        redirect_to connections_path and return
        # if @product.save
        #   flash[:notice] = "New product #{@product.name} created"
        #   redirect_to products_path and return
        # else
        #   flash[:alert] = "Failed to save new product"
        #   redirect_to new_product_path and return
        # end
    end
    
    private
    def account_params
        params.require(:account).permit(:first_name, :last_name, :password,)
    end
end
