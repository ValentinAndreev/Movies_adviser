class ReviewsController < ApplicationController
  before_action :find_review

  def index
    @reviews = @movie.reviews.order(:created_at).page(params[:page]).per(10)
    redirect_to @movie if @reviews.size == 0
  end

  def show; end

  def new
    @review = Review.new
  end

  def edit; end

  def create
    @review = Review.new(review_params)
    @review.user = current_user
    if @review.save
      render :show
    else
      render :new
    end
  end

  def update
    if @review.update(review_params)
      render :show
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
    @review = @commentable = Review.find_by(id: params[:id]) || Review.where(user: current_user, movie_id: params[:movie_id]).first
    @movie = @review&.movie || Movie.find_by(id: params[:movie_id])
    @comments = @commentable.comments.order(:created_at).all if @review
  end
end
