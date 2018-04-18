# frozen_string_literal: true

# :reek:TooManyInstanceVariables { max_instance_variables: 8 }

module Web
  # Movies controller
  class MoviesController < Web::BaseController
    before_action :find_movie, except: :index
    before_action :find_comments, :find_vote, only: :show

    def index
      scope = FindMovies.new(Movie.all, current_user)
      @movies = scope.call(movie_params).distinct
      @message = scope.message(movie_params)
    end

    def show
      @review = Review.where(movie_id: @movie.id, user_id: current_user)
      respond_to do |format|
        format.html
        format.js
      end
    end

    def recommendations
      @recommendations = Movie.where(tmdb_id: @movie.recommendations)
      fresh_when @recommendations
    end

    private

    def movie_params
      params.permit(:recommendation, :page, :current_user, :search, :genres, :sort, :order)
    end

    def find_movie
      @movie = @commentable = MoviePresenter.new(Movie.find(params[:id]))
    end

    def find_comments
      @comments = @movie.comments.order(:created_at).all
    end

    def find_vote
      @vote = Vote.find_by(user_id: current_user, movie_id: @movie.id)
    end
  end
end
