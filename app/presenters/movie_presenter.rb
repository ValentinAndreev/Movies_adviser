# frozen_string_literal: true

# Presenter for movie
class MoviePresenter < SimpleDelegator
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

  private

  def model
    __getobj__
  end
end
