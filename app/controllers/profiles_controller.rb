class ProfilesController < ApplicationController
  def show
    @profile = Account.find(params[:id])
  end
end
