class FindMovies
  attr_accessor :initial_scope

  def initialize(initial_scope)
    @initial_scope = initial_scope
  end

  def call(params)
    @current_user = params[:current_user]
    scoped = @initial_scope
    if params[:recommendation]
      recommendation = recommend_method(params[:recommendation])
      scoped = self.send(recommendation) unless recommendation == ''
    end
    scoped = search(scoped, params[:search]) unless params[:search] == ''
    scoped = search_by_genres(scoped, params[:genres]) unless params[:genres] == ''
    count = scoped.count
    scoped = paginate(scoped, params[:page], params[:sort])
    scoped.reverse_order! if params[:order] == "1"
    [scoped, message(params), count]
  end

  private

  def recommend_method(recommendation)
    meth = recommendation.downcase.sub(' ', '_')
    ['recommended', 'not_recommended', 'neutral', 'not_evaluated'].any? { |word| meth.include?(word) } ? meth : ''
  end

  def recommended
    Movie.where(id: @current_user.votes.where(value: 1).pluck(:movie_id))
  end

  def not_recommended
    Movie.where(id: @current_user.votes.where(value: -1).pluck(:movie_id))
  end

  def neutral
    Movie.where(id: @current_user.votes.where(value: 0).pluck(:movie_id))
  end

  def not_evaluated
    @initial_scope.where.not(id: recommended).merge(@initial_scope.where.not(id: not_recommended)).merge(@initial_scope.where.not(id: neutral))
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

  def message(params)
    return params[:genres].downcase if params.except(:current_user, :genres).blank?  
    return 'all movies' if params[:recommendation] == '' && params.except(:current_user, :recommendation) == ''
    params.except(:current_user, :page).values.delete_if(&:empty?).join(', ').downcase.sub('1', 'reversed  ').remove('0')[0...-2]
  end
end