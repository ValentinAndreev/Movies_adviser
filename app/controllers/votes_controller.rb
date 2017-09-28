class VotesController < ApplicationController
  def update
    @vote = Vote.find_or_create_by(user_id: current_user.id, movie_id: params[:movie_id])
    @vote.update(vote_params)
    redirect_to Movie.find(params[:movie_id])
  end

  private

  def vote_params
    params.permit(:movie_id, :value)
  end
end
