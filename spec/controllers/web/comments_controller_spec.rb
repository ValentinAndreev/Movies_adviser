# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Web::CommentsController, type: :controller do
  describe 'actions' do
    let(:user) { create(:user) }
    let(:movie) { create(:movie) }
    let(:review) { create(:review, user: user, movie: movie) }
    let!(:comment) { create(:comment, commentable_id: review.id, username: user.username) }
    before { sign_in(user) }

    context 'user can create comment to review' do
      subject { post 'create', params: { comment: { body: 'Comment' }, review_id: review.id } }

      it 'saves the new comment to database' do
        expect { subject }.to change(Comment.all, :count).by(1)
      end

      it 'should respond with a success status code (2xx)' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'user can create comment to movie' do
      subject { post 'create', params: { comment: { body: 'Comment' }, movie_id: movie.id } }

      it 'saves the new comment to database' do
        expect { subject }.to change(Comment.all, :count).by(1)
      end

      it 'should respond with a success status code (2xx)' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'user can edit comment' do
      before { put 'update', params: { comment: { body: 'Edited comment' }, review_id: review.id, id: comment.id } }

      it 'comment was edited' do
        expect(comment.reload.body).to eq 'Edited comment'
      end
    end
  end
end
