class ReviewsController < ApplicationController
  before_action :find_review, except: [:my, :index]

  def index
    @movie = Movie.find_by(id: params[:movie_id])
    @reviews = Review.where(movie: @movie).order(:created_at).page(params[:page]).per(10)
    redirect_to Movie.find(params[:movie_id]) if @reviews.size == 0
  end

  def show 
    redirect_to my_review_path(movie_id: @review.movie) if @review.user == current_user    
  end

  def my
    @commentable = Review.where(user: current_user, movie_id: params[:movie_id]).first
    @my_review = @commentable
    @comments = @my_review.comments.order(:created_at).all
  end

  def new
    @review = Review.new
  end

  def edit; end

  def create
    @review = Review.new(review_params)
    @review.user = current_user
    if @review.save
      @my_review = @review
      render :my
    else
      render :new
    end
  end

  def update
    if @review.update(review_params)
      @my_review = @review
      render :my
    else
      render :edit
    end
  end

  def destroy
    movie_id = @review.movie
    @review.destroy
    redirect_to reviews_path(movie_id: movie_id)
  end

  private

  def review_params
    params.require(:review).permit(:movie_id, :text)
  end  

  def find_review
    @movie = Movie.find_by(id: params[:movie_id])
    @commentable = Review.find_by(id: params[:id])
    @review = @commentable
    @comments = @review.comments.order(:created_at).all if @review
  end
end