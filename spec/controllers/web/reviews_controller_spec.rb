# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Web::ReviewsController, type: :controller do
  describe 'actions' do
    let(:user) { create(:user) }
    let(:another_user) { create(:another_user) }
    let(:movie) { create(:movie) }
    let(:review) { create(:review, text: 'Review', user_id: another_user.id, movie_id: movie.id) }
    before { sign_in(user) }

    context 'user can create review' do
      subject { post 'create', params: { review: { text: 'Review', movie_id: movie.id } } }

      it 'saves the new review to database' do
        expect { subject }.to change(Review.all, :count).by(1)
      end

      it 'should redirect to review' do
        is_expected.to redirect_to(Review.last)
      end
    end

    context 'user can edit review' do
      before { put 'update', params: { review: { text: 'Edited review', movie_id: movie.id }, id: review.id } }

      it 'comment was edited' do
        expect(review.reload.text).to eq 'Edited review'
      end
    end
  end
end
