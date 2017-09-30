class CommentsController < ApplicationController
  before_action :set_comment

  def new
    @comment = @movie.comments.new
  end

  def create
    @comment = @movie.comments.new(comment_params)
    @comment.username = current_user.username
    render 'new' unless @comment.save
    respond_to do |format|
      format.html { redirect_to @movie, notice: 'Comment was created' }
      format.js
    end
  end

  def update
    @comment.update(comment_params)
    render 'edit' unless @comment.update(comment_params)
    respond_to do |format|
      format.html { redirect_to @movie, notice: 'Comment was updated' }
      format.js
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to @movie, notice: 'Comment was deleted' }
      format.js
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:user, :body)
  end

  def set_comment
    @movie = Movie.find(params[:movie_id]) if params[:movie_id]
    @comment = @movie.comments.find(params[:id]) if params[:id]
    @comments = @movie.comments.all
  end
end