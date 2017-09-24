module MoviesHelper
  def poster_path(movie, size)
    @base_url + size + movie.poster_path
  end

  def title(movie)
    movie.title.size > 27 ? movie.title[0..24] + '...' : movie.title
  end
end