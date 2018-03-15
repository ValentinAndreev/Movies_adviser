# frozen_string_literal: true

# :reek:TooManyInstanceVariables { max_instance_variables: 10 }

module Web
  # Movies controller
  class MoviesController < Web::BaseController
    before_action :find_movie, except: :index
    before_action :rating, only: :show

    def index
      scope = FindMovies.new(Movie.all, current_user)
      @movies = scope.call(movie_params)
      @message = scope.message(movie_params)
    end

    def show
      @review = Review.where(movie_id: @movie, user_id: current_user)
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
      params.permit(:recommendation, :page, :current_user, :search, :genres, :sort, :order)
    end

    def find_movie
      @movie = @commentable = Movie.find(params[:id])
      @vote = Vote.find_by(user_id: current_user, movie_id: @movie)
      @comments = @movie.comments.order(:created_at).all
    end

    def rating
      @rating = @movie.rating
      @votes = @movie.all_votes.count
    end
  end
end
