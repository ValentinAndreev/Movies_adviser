# frozen_string_literal: true

# :reek:DuplicateMethodCall { exclude: [ my_review_link ] }
# :reek:UtilityFunction { exclude: [ routes ] }

# Presenter for movie
class MoviePresenter < SimpleDelegator
  include ActionView::Helpers::UrlHelper

  def title_year
    @title_year ||= "#{model.title} (#{model.release_date.year})"
  end

  def poster_path(size)
    @poster_path ||= 'http://image.tmdb.org/t/p/' + size + model.poster_path
  end

  def short_title
    title = model.title
    @short_title ||= title.size > 27 ? title[0..24] + '...' : title
  end

  def recommendation(vote = nil)
    return 'Your recommendation: not evaluated' unless vote
    vote_hash = { 1 => 'recommended', -1 => 'not recommended', 0 => 'neutral' }
    @recommendation ||= "Your recommendation: #{vote_hash[vote.value]}"
  end

  def rating
    @rating ||= model.votes.average(:value) || 0
  end

  def rating_title
    @rating_title ||= "Rating: (from -1 - not recommended, to 1 - recommended): #{rating} (#{model.votes.count} votes)."
  end

  def all_review_link
    link_to 'All reviews', routes.reviews_path(movie_id: model) if model.reviews_count.positive?
  end

  def my_review_link(review)
    if review.first
      link_to 'My review', routes.review_path(id: review.first)
    else
      link_to 'Create review', routes.new_review_path(movie_id: model)
    end
  end

  private

  def routes
    Rails.application.routes.url_helpers
  end

  def model
    __getobj__
  end
end
