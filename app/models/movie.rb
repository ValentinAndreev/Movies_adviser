class Movie < ApplicationRecord
  has_many :comments
  validates :title, :overview, :poster_path, :vote_average, :imbd_id, :tmdb_id, :release_date, :genres, presence: true
end