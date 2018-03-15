# frozen_string_literal: true

# :reek:NilCheck { exclude: [ find_movie ] }
# :reek:TooManyInstanceVariables { max_instance_variables: 5 }

class ReviewsController < ApplicationController
  before_action :find_review
  before_action :find_comments
  before_action :find_movie

  def index
    @reviews = @movie.reviews.order(:created_at).page(params[:page]).per(10)
    redirect_to @movie if @reviews.empty?
  end

  def show; end

  def new
    @review = Review.new
  end

  def edit; end

  def create
    @review = Review.new(review_params.merge(user: current_user))
    if @review.save
      redirect_to @review
    else
      render :new
    end
  end

  def update
    if @review.update(review_params)
      redirect_to @review
    else
      render :edit
    end
  end

  def destroy
    @review.destroy
    redirect_to reviews_path(movie_id: @movie.id)
  end

  private

  def review_params
    params.require(:review).permit(:movie_id, :text)
  end

  def find_review
    @review = Review.find_by(id: params[:id]) || Review.where(user: current_user, movie_id: params[:movie_id]).first
  end

  def find_comments
    @commentable = @review
    @comments = @review.comments.order(:created_at).all if @review
  end

  def find_movie
    @movie = @review&.movie || Movie.find_by(id: params[:movie_id])
  end
end
