# frozen_string_literal: true

require 'rails_helper'

feature 'Admin - dashboard' do
  let!(:user) { create(:user, username: 'admin', role: 'admin') }

  scenario 'admin can see link to dashboard' do
    log_in_user(user.username, user.password)
    expect(page).to have_content 'Admin root'
  end
end
