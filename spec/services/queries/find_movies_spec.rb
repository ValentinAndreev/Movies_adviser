require 'rails_helper'

describe 'Query tests' do
  let(:user) { create(:user) }
  let(:movie) { create(:movie) }
  let(:another_movie) { create(:movie, title: 'Gladiator', tmdb_id: 98) }
  let(:vote) { create(:vote, user_id: user.id, movie_id: movie.id) }
  let(:another_vote) { create(:vote, user_id: user.id, movie_id: another_movie.id, value: -1) }

  context 'find move' do
    it 'returns all' do
      movies = FindMovies.new(Movie.all).call({ recommendation: 'all movies  ', current_user: user })
      expect(movies[1]).to eq('all movies')
    end

    it 'returns recommended' do
      movies = FindMovies.new(Movie.all).call({ recommendation: 'Recommended', current_user: user })
      expect(movies[1]).to eq('recommend')
    end

    it 'returns not recommended' do
      movies = FindMovies.new(Movie.all).call({ recommendation: 'Not recommended', current_user: user })
      expect(movies[1]).to eq('not recommend')
    end
  end
end