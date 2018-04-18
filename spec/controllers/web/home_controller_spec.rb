# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Web::HomeController, type: :controller do
  let(:user) { create(:user) }

  describe '#index' do
    before do
      sign_in(user)
      get :index
    end

    it { is_expected.to render_template(:index) }
    it 'should respond with a success status code (2xx)' do
      expect(response).to have_http_status(200)
    end
  end
end
