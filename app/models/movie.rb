class Movie < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :reviews, dependent: :destroy  
  validates :title, :overview, :poster_path, :vote_average, :imbd_id, :tmdb_id, :release_date, :genres, presence: true

  def recommendations
    Movie.where(tmdb_id: Movie.pluck(:tmdb_id) & Tmdb::Movie.recommendations(tmdb_id).results.pluck(:id))
  end
end