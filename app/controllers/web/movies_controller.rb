# frozen_string_literal: true

module Web
  # Movies controller
  class MoviesController < Web::BaseController
    before_action :find_movie, except: :index
    respond_to :js, :html, only: :show

    def index
      movies = FindMovies.new(Movie.all, current_user).call(movie_params).distinct
      message = FindMoviesMessage.message(movie_params)
      render :index, locals: { movies: movies, message: message }
    end

    def show
      id = @movie.id
      review = Review.where(movie_id: id, user_id: current_user)
      comments = @movie.comments.order(:created_at).all
      vote = Vote.find_by(user_id: current_user, movie_id: id)
      render :show, locals: { review: review, comments: comments, vote: vote }
    end

    def recommendations
      @recommendations = Movie.where(tmdb_id: @movie.recommendations)
    end

    private

    def movie_params
      params.permit(:recommendation, :page, :current_user, :search, :genres, :sort, :order)
    end

    def find_movie
      @movie = @commentable = MoviePresenter.new(Movie.find(params[:id]))
    end
  end
end
