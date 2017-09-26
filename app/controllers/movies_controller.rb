class MoviesController < ApplicationController
  before_action :base_url

  def index
    @movies = Movie.order(:created_at).all.page(params[:page]).per(10)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @movie = Movie.find(params[:id])
    @comments = @movie.comments.order(:created_at).all
    respond_to do |format|
      format.html
      format.js
    end
  end

  def recommendations
    @movie = Movie.find(params[:id])
    @recommendations = Movie.recommendations(@movie.tmdb_id)
  end
  
  private

  def movie_params
    params.require(:movie).permit(:poster_path, :vote_average, :overview, :title, :tmdb_id, :imdb_id)
  end

  def base_url
    @base_url ||= Tmdb::Configuration.get.images.base_url
  end
end
