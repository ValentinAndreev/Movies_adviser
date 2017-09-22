class MoviesController < ApplicationController
  before_action :define_base_url

  def index
    @movies = Movie.order(:id).all.page(params[:page]).per(10)
  end

  def show
    @movie = Movie.find(params[:id])
  end

  private
  def define_base_url
    @base_url = Tmdb::Configuration.get.images.base_url+'w300'
  end
end
