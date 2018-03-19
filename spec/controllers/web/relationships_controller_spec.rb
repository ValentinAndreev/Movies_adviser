# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Web::RelationshipsController, type: :controller do
  describe 'actions' do
    let(:user) { create(:user) }
    let(:another_user) { create(:another_user) }
    before { sign_in(user) }

    context 'user can follow to another user' do
      before { post :create, params: { followed_id: another_user.id } }

      it 'should create the relationship' do
        expect(user.followings?(another_user)).to eq(true)
      end

      it 'should redirect to followed user page' do
        expect(subject).to redirect_to(user_path(another_user))
      end
    end

    context 'user can unfollow from followings user' do
      before do
        post :create, params: { followed_id: another_user.id }
        delete :destroy, params: { id: user.active_relationships.find_by(followed_id: another_user.id) }
      end

      it 'should destroy the relationship' do
        expect(user.followings?(another_user)).to eq(false)
      end

      it 'should redirect to followed user page' do
        expect(subject).to redirect_to(user_path(another_user))
      end
    end
  end
end
