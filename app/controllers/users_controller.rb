class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all.order(:created_at).page(params[:page]).per(10)
  end
end
