class MoviesController < ApplicationController
  before_action :find_movie, except: [:index, :recommended, :not_recommended]

  def index
    @movies = Movie.order(:created_at).page(params[:page]).per(10)
  end

  def recommended
    @movies = Movie.where(id: current_user.recommended).page(params[:page]).per(10)
  end

  def not_recommended
    @movies = Movie.where(id: current_user.not_recommended).page(params[:page]).per(10)    
  end

  def show
    @comments = @movie.comments.order(:created_at).all
    respond_to do |format|
      format.html
      format.js
    end
  end

  def recommendations
    @recommendations = @movie.recommendations
  end

  private

  def movie_params
    params.require(:movie).permit(:poster_path, :vote_average, :overview, :title, :tmdb_id, :imdb_id)
  end

  def find_movie
    @movie = Movie.find(params[:id])
    @vote = Vote.find_or_create_by(user_id: current_user.id, movie_id: @movie)
  end
end
