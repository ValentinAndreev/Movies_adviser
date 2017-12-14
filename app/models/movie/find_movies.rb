class FindMovies
  def initialize(initial_scope, current_user)
    @scoped = initial_scope
    @current_user = current_user
  end

  def call(params)
    @scoped = recommendation(params[:recommendation]) unless params[:recommendation] == ''
    @scoped = search(@scoped, params[:search]) unless params[:search] == ''
    @scoped = search_by_genres(@scoped, params[:genres]) unless params[:genres] == ''
    @scoped = paginate(@scoped, params[:page], params[:sort])
    @scoped.reverse_order! if params[:order] == "1"
    @scoped
  end

  def message(params)
    return params[:genres].downcase if params.except(:genres) == ''
    message = params.except(:page).values.delete_if(&:empty?).join(', ').downcase.sub('1', 'reversed').chomp(', 0')
    return message == '0' ? 'all movies' : message
  end

  private

  def recommendation(level)
    h = { 'Recommended' => 1, 'Not recommended' => -1, 'Neutral' => 0 }
    if h[level]
      Movie.where(id: @current_user.votes.where(value: h[level]).select(:movie_id))
    else
      Movie.where.not(id: @current_user.votes.where(value: [-1, 0, 1]).select(:movie_id))
    end
  end

  def paginate(scoped, page, sort)
    sort == 'Date' ? scoped.order(:release_date ).page(page).per(10) : scoped.order(vote_average: :desc).page(page).per(10)
  end

  def search(scoped, query)
    query ? scoped.where('title ILIKE ?', "%#{query}%") : scoped
  end

  def search_by_genres(scoped, genres)
    genres ? scoped.where("genres @> ARRAY[?]::varchar[]", genres) : scoped
  end
end
