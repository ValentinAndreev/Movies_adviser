class Movie < ApplicationRecord
  has_many :comments
  validates :title, :overview, :poster_path, :vote_average, :imbd_id, :tmdb_id, :release_date, :genres, presence: true
  
  def self.bd_tmdb
    Movie.pluck(:tmdb_id)
  end

  def self.recommendations(tmdb_id)
    rec = Tmdb::Movie.recommendations(tmdb_id).results.pluck(:id)
    Movie.where(tmdb_id: bd_tmdb & rec)
  end
end