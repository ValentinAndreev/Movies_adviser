module MoviesHelper
  def poster_path(movie, size)
    "http://image.tmdb.org/t/p/" + size + movie.poster_path
  end

  def title(movie)
    title = movie.title
    title.size > 27 ? title[0..24] + '...' : title
  end

  def recommendation
    h = { 1 =>'recommended', -1 =>'not recommended', 0 => 'neutral' }
    h.key?(@vote&.value) ? h[@vote.value] : 'not evaluated'
  end
end