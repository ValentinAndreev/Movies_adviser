# frozen_string_literal: true

# :reek:TooManyStatements { exclude: [ create ] }

class CommentsController < ApplicationController
  before_action :find_commentable
  before_action :find_comment

  def new
    @comment = @commentable.comments.new
  end

  def create
    @comment = @commentable.comments.new(comment_params.merge(username: current_user.username))
    render :new unless @comment.save
    respond_to do |format|
      format.html { redirect_to @commentable, notice: 'Comment was created' }
      format.js
    end
  end

  def update
    render :edit unless @comment.update(comment_params)
    respond_to do |format|
      format.html { redirect_to @commentable, notice: 'Comment was updated' }
      format.js
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to @commentable, notice: 'Comment was deleted' }
      format.js
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:user, :body, :movie_id, :review_id)
  end

  def find_commentable
    resource, id = request.path.split('/')[1, 2]
    @commentable = resource.singularize.classify.constantize.find(id)
    @comments = @commentable.comments.all
  end

  def find_comment
    @comment = @commentable.comments.find_by(id: params[:id])
  end
end
