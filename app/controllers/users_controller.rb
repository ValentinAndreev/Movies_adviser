# frozen_string_literal: true

# Users and followers/followings controler
class UsersController < ApplicationController
  before_action :find_user, except: :index

  def show
    @followed = current_user.active_relationships.find_by(followed_id: @user.id)
  end

  def index
    @users = User.all.order(:created_at).page(params[:page]).per(10)
  end

  def following
    @users = @user.following.order(:created_at).page(params[:page]).per(10)
    render 'show_follow'
  end

  def followers
    @users = @user.followers.order(:created_at).page(params[:page]).per(10)
    render 'show_follow'
  end

  private

  def find_user
    @user = User.find(params[:id])
  end
end
