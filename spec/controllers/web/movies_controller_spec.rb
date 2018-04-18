# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Web::MoviesController, type: :controller do
  describe 'actions' do
    let(:user) { create(:user) }
    let(:movie) { create(:movie) }
    before { sign_in(user) }

    context 'user can see list of movies' do
      before { get :index }

      it { is_expected.to render_template(:index) }
      it 'should respond with a success status code (2xx)' do
        expect(response).to have_http_status(200)
      end
    end

    context 'user can visit single movie page' do
      before { get :show, params: { id: movie.id } }

      it { is_expected.to render_template(:show) }
      it 'should respond with a success status code (2xx)' do
        expect(response).to have_http_status(200)
      end
    end

    context 'user can visit page with TMDB recommendations for movie' do
      before { get :recommendations, params: { id: movie.id } }

      it { is_expected.to render_template('web/movies/recommendations') }
      it 'should respond with a success status code (2xx)' do
        expect(response).to have_http_status(200)
      end
    end
  end
end
