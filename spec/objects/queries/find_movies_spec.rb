# frozen_string_literal: true

require 'rails_helper'

describe 'Query tests' do
  let!(:user) { create(:user) }
  let!(:movie) { create(:movie) }
  let!(:another_movie) { create(:another_movie) }
  let!(:vote) { create(:vote, user_id: user.id, movie_id: movie.id) }
  let!(:another_vote) { create(:vote, user_id: user.id, movie_id: another_movie.id, value: -1) }

  before { @scope = FindMovies.new(Movie.all, user) }

  context 'find move' do
    it 'returns all' do
      movies = @scope.call(recommendation: '', order: '0')
      message = FindMoviesMessage.message(recommendation: '', order: '0')
      expect(movies.count).to eq(2)
      expect(message).to eq('all movies')
    end

    it 'returns recommended' do
      movies = @scope.call(recommendation: 'Recommended')
      message = FindMoviesMessage.message(recommendation: 'Recommended')
      expect(movies.first.title).to eq('The Shawshank Redemption')
      expect(message).to eq('recommended')
    end

    it 'returns not recommended' do
      movies = @scope.call(recommendation: 'Not recommended')
      message = FindMoviesMessage.message(recommendation: 'Not recommended')
      expect(movies.first.title).to eq('Gladiator')
      expect(message).to eq('not recommended')
    end

    it 'returns neutral' do
      message = FindMoviesMessage.message(recommendation: 'Neutral')
      expect(message).to eq('neutral')
    end

    it 'returns not evaluated' do
      message = FindMoviesMessage.message(recommendation: 'Not evaluated')
      expect(message).to eq('not evaluated')
    end

    it 'returns by genres' do
      movies = @scope.call(recommendation: '', genres: 'Crime')
      message = FindMoviesMessage.message(genres: 'Crime')
      expect(movies.first.title).to eq('The Shawshank Redemption')
      expect(message).to eq('crime')
    end

    it 'returns by date' do
      movies = @scope.call(recommendation: '', sort: 'Date')
      message = FindMoviesMessage.message(sort: 'Date')
      expect(movies.first.title).to eq('Gladiator')
      expect(movies.second.title).to eq('The Shawshank Redemption')
      expect(message).to eq('date')
    end

    it 'returns by reversed IMDB rating' do
      movies = @scope.call(recommendation: '', order: '1')
      message = FindMoviesMessage.message(order: '1')
      expect(movies.first.title).to eq('Gladiator')
      expect(movies.second.title).to eq('The Shawshank Redemption')
      expect(message).to eq('reversed')
    end

    it 'returns by searched text' do
      movies = @scope.call(recommendation: '', search: 'shank')
      message = FindMoviesMessage.message(search: 'shank')
      expect(movies.first.title).to eq('The Shawshank Redemption')
      expect(message).to eq('shank')
    end
  end
end
