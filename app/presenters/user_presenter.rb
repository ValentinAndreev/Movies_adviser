# frozen_string_literal: true

# Presenter for user
class UserPresenter < SimpleDelegator
  def reviews_votes
    @reviews_votes ||= "Reviews #{model.reviews.count} Votes #{model.votes.count}"
  end

  def action(current_user)
    return 'profile' if model == current_user
    @action ||= current_user.followings?(model) ? 'unfollow' : 'follow'
  end

  private

  def model
    __getobj__
  end
end
