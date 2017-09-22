class MoviesController < ApplicationController
  before_action :base_url

  def index
    @movies = Movie.order(:id).all.page(params[:page]).per(10)
  end

  def show
    @movie = Movie.find(params[:id])
    @recommendations = Tmdb::Movie.recommendations(@movie.tmdb_id).results[0..11]
  end
  
  private

  def movie_params
    params.require(:movie).permit(:poster_path, :vote_average, :overview, :title, :tmdb_id, :imdb_id)
  end

  def base_url
    @base_url ||= Tmdb::Configuration.get.images.base_url+'w300'
  end
end
