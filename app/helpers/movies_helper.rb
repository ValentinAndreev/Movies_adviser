module MoviesHelper
  def poster_path(movie, size)
    @base_url ||= "http://image.tmdb.org/t/p/"
    @base_url + size + movie.poster_path
  end

  def title(movie)
    title = movie.title
    title.size > 27 ? title[0..24] + '...' : title
  end

  def recommendation
    if @vote.value == 1
      'recommended'
    elsif @vote.value == -1
      'not recommended'
    else
      'neutral'
    end
  end
end