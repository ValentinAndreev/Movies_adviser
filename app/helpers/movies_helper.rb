module MoviesHelper
  def poster_path(movie)
    @base_url + movie.poster_path
  end

  def title(movie)
    movie.title.size > 30 ? movie.title[0..27] + '...' : movie.title
  end
end