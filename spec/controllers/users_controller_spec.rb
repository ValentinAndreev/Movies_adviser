# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'actions' do
    let(:user) { create(:user) }
    let(:another_user) { create(:another_user) }
    let(:invalid_user) { build(:user, username: nil, password: nil) }

    context 'sign in with valid parameters' do
      before do
        sign_in(user)
        get :index
      end

      it { is_expected.to render_template(:index) }
      it 'should respond with a success status code (2xx)' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'sign in with invalid parameters' do
      before do
        sign_in(invalid_user)
        get :index
      end

      it 'should redirect to sign in' do
        is_expected.to redirect_to(user_session_path)
      end
    end

    context 'user can visit users profile' do
      before do
        sign_in(user)
        get :show, params: { id: user.id }
      end

      it { is_expected.to render_template(:show) }
      it 'should respond with a success status code (2xx)' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'user can see followings/followers of user' do
      before do
        sign_in(user)
        get :followers, params: { id: user.id }
      end

      it { is_expected.to render_template('users/show_follow') }
      it 'should respond with a success status code (2xx)' do
        expect(response).to have_http_status(:success)
      end
    end
  end
end
