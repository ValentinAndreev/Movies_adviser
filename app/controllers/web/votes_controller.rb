# frozen_string_literal: true

# :reek:DuplicateMethodCall { exclude: [ update ] }
# :reek:TooManyStatements { exclude: [ update ] }

module Web
  # Vote for movies controller
  class VotesController < Web::BaseController
    def update
      @vote = Vote.find_or_create_by(user_id: current_user.id, movie_id: params[:movie_id])
      @vote.update(vote_params)
      respond_to do |format|
        format.html { redirect_to Movie.find(params[:movie_id]) }
        format.js
      end
    end

    private

    def vote_params
      params.permit(:movie_id, :value)
    end
  end
end
