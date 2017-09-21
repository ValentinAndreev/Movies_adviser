class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @base_url = Tmdb::Configuration.get.images.base_url+'w300'
    @movies = Movie.order(:id).all.page(params[:page]).per(10)
  end
end