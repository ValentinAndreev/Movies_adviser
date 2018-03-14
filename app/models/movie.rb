# frozen_string_literal: true

class Movie < ApplicationRecord
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :reviews, dependent: :destroy
  validates :title, :overview, :poster_path, :vote_average, :imbd_id, :tmdb_id, :release_date, :genres, presence: true

  def recommendations
    Movie.where(tmdb_id: Movie.pluck(:tmdb_id) & Tmdb::Movie.recommendations(tmdb_id).results.pluck(:id))
  end

  def rating
    votes_number = all_votes.count
    votes_number.positive? ? (all_votes.sum.to_f / votes_number.to_f).round(2) : 0
  end

  def all_votes
    votes.pluck(:value)
  end
end
