class AccountsController < Devise::RegistrationsController
  before_action :authenticate_account!, except: [:create, :new]
  
  def new
    super
  end
  
  def create
    @account = Account.new(account_params)

    if @account.save
      flash[:notice] = "Account successfully created. Please check email for verification link."
        redirect_to connections_path and return
    else
      flash[:alert] = "Failed to create account."
        render new_account_path and return
    end
  end
  
    
  # def edit
  #     @account = Account.find(params[:id])
  # end

  # def update 
  #   @account = Account.find(params[:id])
  #   # @profile.avatar.attach(params[:avatar])
  #   # @profile.photos.attach(params[:photos])
  #   if @account.update_without_password(account_params)
  #     flash[:success] = "Profile updated!"
  #     redirect_to profile_path(@profile)
  #   else 
  #     # redirect_to profile_path(@profile)
  #     respond_to do |format|
  #       format.html { render :edit }
  #     end
  #   end
  # end 
  
  private
    def account_params
        params.require(:account).permit(:first_name, :last_name, :email, :password, :pronouns, :class_year, :avatar, :photos => [], :majors => [], :minors => [], :interests => [])
    end
end
