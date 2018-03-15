# frozen_string_literal: true

# :reek:ControlParameter { exclude: [ paginate ] }
# :reek:DuplicateMethodCall { exclude: [ recommendation ]
# :reek:FeatureEnvy { exclude: [ call ]
# :reek:TooManyStatements { exclude: [ call ] }
# :reek:UtilityFunction { exclude: [ message ] }

class FindMovies
  attr_reader :initial_scope
  attr_reader :current_user

  def initialize(initial_scope, current_user)
    @initial_scope = initial_scope
    @current_user = current_user
  end

  def call(params)
    scoped = recommendation(initial_scope, params[:recommendation])
    scoped = FindMovies.search(scoped, params[:search])
    scoped = FindMovies.search_by_genres(scoped, params[:genres])
    scoped = FindMovies.paginate(scoped, params[:page], params[:sort])
    scoped.reverse_order! if params[:order] == '1'
    scoped
  end

  def message(params)
    return params[:genres].downcase if params.except(:genres) == ''
    message = params.except(:page).values.delete_if(&:empty?).join(', ').downcase.chomp(', 0')
    message.sub!('1', 'reversed') if params[:order] == '1'
    message == '0' ? 'all movies' : message
  end

  def self.paginate(scoped, page, sort)
    scoped = sort == 'Date' ? scoped.order(:release_date) : scoped.order(vote_average: :desc)
    scoped.page(page).per(10)
  end

  def self.search(scoped, query = '')
    query.to_s.empty? ? scoped : scoped.where('title ILIKE ?', "%#{query}%")
  end

  def self.search_by_genres(scoped, genres = '')
    genres.to_s.empty? ? scoped : scoped.where('genres @> ARRAY[?]::varchar[]', genres)
  end

  private

  def recommendation(scoped, level)
    return scoped if level == ''
    vote = { 'Recommended' => 1, 'Not recommended' => -1, 'Neutral' => 0 }
    vote[level] ? voted_movie(vote[level]) : not_evaluated
  end

  def voted_movie(vote)
    Movie.where(id: current_user.votes.where(value: vote).select(:movie_id))
  end

  def not_evaluated
    Movie.where.not(id: current_user.votes.where(value: [-1, 0, 1]).select(:movie_id))
  end
end
