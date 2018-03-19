# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Web::VotesController, type: :controller do
  describe 'actions' do
    let(:user) { create(:user) }
    let(:movie) { create(:movie) }
    before { sign_in(user) }

    context 'user can set recommended status for movie ' do
      before { patch :update, params: { movie_id: movie.id, value: 1 } }

      it 'should set recommended status' do
        expect(Vote.where(user_id: user, movie_id: movie).first.value).to eq(1)
      end
    end

    context 'user can set neutral status for movie ' do
      before { patch :update, params: { movie_id: movie.id, value: 0 } }

      it 'should set neutral status' do
        expect(Vote.where(user_id: user, movie_id: movie).first.value).to eq(0)
      end
    end

    context 'user can set notrecommended status for movie ' do
      before { patch :update, params: { movie_id: movie.id, value: -1 } }

      it 'should set notrecommended status' do
        expect(Vote.where(user_id: user, movie_id: movie).first.value).to eq(-1)
      end
    end
  end
end
