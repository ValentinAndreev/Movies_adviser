# frozen_string_literal: true

# Movie model
class Movie < ApplicationRecord
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :reviews, dependent: :destroy
  validates :title, :overview, :poster_path, :vote_average, :imbd_id, :tmdb_id, :release_date, :genres, presence: true

  delegate :count, to: :reviews, prefix: true
end
