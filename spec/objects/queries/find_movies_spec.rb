require 'rails_helper'

describe 'Query tests' do
  let!(:user) { create(:user) }
  let!(:movie) { create(:movie) }
  let!(:another_movie) { create(:movie, title: 'Gladiator', tmdb_id: 98) }
  let!(:vote) { create(:vote, user_id: user.id, movie_id: movie.id) }
  let!(:another_vote) { create(:vote, user_id: user.id, movie_id: another_movie.id, value: -1) }

  before { @scope = FindMovies.new(Movie.all, user) }

  context 'find move' do
    it 'returns all' do
      movies = @scope.call({ recommendation: '', order: '0' })
      message = @scope.message({ recommendation: '', order: '0' })
      expect(movies.count).to eq(2)
      expect(message).to eq('all movies')
    end

    it 'returns recommended' do
      message = @scope.message({ recommendation: 'Recommended' })
      expect(message).to eq('recommended')
    end

    it 'returns not recommended' do
      message = @scope.message({ recommendation: 'Not recommended' })
      expect(message).to eq('not recommended')
    end

    it 'returns neutral' do
      message = @scope.message({ recommendation: 'Neutral' })
      expect(message).to eq('neutral')
    end

    it 'returns not evaluated' do
      message = @scope.message({ recommendation: 'Not evaluated' })
      expect(message).to eq('not evaluated')
    end

    it 'returns by genres' do
      message = @scope.message({ genres: 'Crime' })
      expect(message).to eq('crime')
    end

    it 'returns by date' do
      message = @scope.message({ sort: 'Date' })
      expect(message).to eq('date')
    end

    it 'returns by reversed order' do
      message = @scope.message({ order: '1' })
      expect(message).to eq('reversed')
    end

    it 'returns by serched text' do
      message = @scope.message({ search: 'text' })
      expect(message).to eq('text')
    end
  end
end