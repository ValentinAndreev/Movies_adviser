# frozen_string_literal: true

# :reek:NilCheck { exclude: [ recommendation ] }
# :reek:UtilityFunction { exclude: [ poster_path, title ] }

module MoviesHelper
  def poster_path(movie, size)
    'http://image.tmdb.org/t/p/' + size + movie.poster_path
  end

  def title(movie)
    title = movie.title
    title.size > 27 ? title[0..24] + '...' : title
  end

  def recommendation
    vote = { 1 => 'recommended', -1 => 'not recommended', 0 => 'neutral' }
    vote.key?(@vote&.value) ? vote[@vote.value] : 'not evaluated'
  end
end
