class MoviesController < ApplicationController
  before_action :find_movie, except: [:index]

  def index  
    @movies = FindMovies.new(Movie.all).call(movie_params)
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
    params.permit(:recommendation, :page, :current_user)
    params.merge!(current_user: current_user)
  end

  def find_movie
    @movie = Movie.find(params[:id])
    @vote = Vote.find_or_create_by(user_id: current_user.id, movie_id: @movie)
  end
end
