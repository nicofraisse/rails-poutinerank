class UsersController < ApplicationController
  skip_after_action :verify_authorized, only: [:show]
  def show
    @user = User.find(params[:id])
  end
end
