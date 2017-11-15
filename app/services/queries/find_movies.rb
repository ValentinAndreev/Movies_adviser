class FindMovies
  attr_accessor :initial_scope

  def initialize(initial_scope)
    @initial_scope = initial_scope  
  end

  def call(params)
    scoped = @initial_scope
    if params[:recommendation] == 'recommended'
      scoped = recommended(scoped, params[:current_user])
    elsif params[:recommendation] == 'not recommended'
      scoped = not_recommended(scoped, params[:current_user])
    end
    scoped = search(scoped, params[:search])
    scoped = search_by_genres(scoped, params[:genres]) unless params[:genres] == ''
    count = scoped.count
    scoped = paginate(scoped, params[:page])
    [scoped, message(params), count]
  end

  private

  def recommended(scoped, current_user)
    Movie.where(id: current_user.votes.where(value: 1).pluck(:movie_id))
  end

  def not_recommended(scoped, current_user)
    Movie.where(id: current_user.votes.where(value: -1).pluck(:movie_id))
  end

  def paginate(scoped, page)
    scoped.order(:created_at).page(page).per(10)
  end

  def search(scoped, query = nil)
    query ? scoped.where('title ILIKE ?', "%#{query}%") : scoped
  end

  def search_by_genres(scoped, genres)
    genres ? scoped.where("genres @> ARRAY[?]::varchar[]", genres) : scoped
  end

  def message(params)
    params[:search] || params[:genres] ? 'searched' : params[:recommendation] || 'all'
  end
end