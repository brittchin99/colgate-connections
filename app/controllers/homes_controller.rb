class HomesController < ApplicationController
  before_action :authenticate_account!, except: [:index]
  def index
    redirect_to profile_path(current_account) if account_signed_in?
  end
end
